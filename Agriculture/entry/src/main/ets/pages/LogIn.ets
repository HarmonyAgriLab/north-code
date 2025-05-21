import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import common from '@ohos.app.ability.common';
import window from '@ohos.window';
import AGCCloud from '../AGC-Cloud/AGC-Cloud';
import { BreakpointKey, BreakpointSystem } from '../common/breakpointsystem'
import { Air } from '../models/Air'
import { Soil } from '../models/Soil';

@Entry
@Component
struct LogIn {
  @StorageProp('DeviceType') deviceType: string = ''
  @State phoneNumber: string = '' // 用户输入的电话号码
  @State verifyCode: string = '' // 用户输入的验证码
  @State countDown: number = 30 // 验证码倒计时
  @State intervalId: number = 0 // 计时器ID
  @State verifyCodeButtonText: string = '获取验证码' // 获取验证码按钮文本
  @State verifyCodeButtonEnable: boolean = true // 验证码按钮可用状态
  @State loginEnable: boolean = false // 登录成功状态1

  @StorageLink('AirData') airData: Air[] = []
  @StorageLink('SoilData') soilData: Soil[] = []

  // 1. 引入 AppStorage 中保存的断点值
  @StorageLink(BreakpointKey)
  currentBreakpoint: string = 'lg'
  // 2. 实例化 BreakpointSystem对象
  breakpointSystem: BreakpointSystem = new BreakpointSystem()

  // 3. 注册及移除事件
  aboutToAppear(): void {
    this.breakpointSystem.register()
  }

  aboutToDisappear(): void {
    this.breakpointSystem.unregister()
  }

  verifyCodeWaiting() {
    this.verifyCodeButtonEnable = false
    this.intervalId = setInterval(() => {
      if (this.countDown < 0) {
        clearInterval(this.intervalId)
        this.countDown = 30
        this.intervalId = 0
        this.verifyCodeButtonEnable = true
        this.verifyCodeButtonText = '获取验证码'
        return
      }
      this.countDown--
    }, 1000)
  }

  async onPageShow() {
    let context = getContext(this) as common.UIAbilityContext
    let lastWindow: window.Window = await window.getLastWindow(context)
    if (lastWindow) {
      lastWindow.setPreferredOrientation(window.Orientation.PORTRAIT)
    }
  }

  build() {
    //  内容区域
    GridRow({
      // 分别设置不同断点的 列数
      columns: {
        sm: 4,
        md: 8,
        lg: 12
      }
    }) {
      // 列
      GridCol({
        // 分别设置不同断点的 所占列数
        span: {
          sm: 4,
          md: 6,
          lg: 8
        },
        // 分别设置不同断点的 偏移
        offset: {
          md: 1,
          lg: 2
        }

      }) {
        Column({ space: 25 }) {
          Text('开源鸿蒙智慧农业终端')
            .fontSize(this.currentBreakpoint == 'lg' ? 35 : 25)
            .fontColor(Color.Yellow)
            .fontWeight(FontWeight.Bold)

          TextInput({ placeholder: '请输入手机号' })
            .type(InputType.Number)
            .width('90%')
            .height(45)
            .backgroundColor('#ffffffff')
            .borderRadius(10)
            .onChange(val => {
              this.phoneNumber = val
            })

          Row({ space: 5 }) {
            TextInput({ placeholder: '请输入验证码' })
              .id('01')
              .type(InputType.Number)
              .width('65%')
              .height(45)
              .backgroundColor('#ffffffff')
              .borderRadius(10)
              .onChange(val => {
                this.verifyCode = val
              })

            Button(this.verifyCodeButtonEnable ? this.verifyCodeButtonText : this.countDown.toString() + 's')
              .backgroundColor('#ff266f47')
              .layoutWeight(1)
              .enabled(this.phoneNumber.length === 11 && this.verifyCodeButtonEnable)
              .onClick(async () => {
                focusControl.requestFocus('01')
                this.verifyCodeWaiting() // 验证码倒计时
                await AGCCloud.requestVerifyCode(this.phoneNumber) // 发送验证码
              })
          }
          .width('90%')


          Button() {
            if (this.loginEnable == true) {
              LoadingProgress()
                .width(30)
                .height(30)
                .color(Color.White)
            } else {
              Text('登录')
                .fontColor(Color.White)
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
            }
          }
          .height(45)
          .width(150)
          .enabled(!this.loginEnable)
          .backgroundColor('#ff266f47')
          .onClick(
              // async () => {
            //   let result = await AGCCloud.createUser(this.phoneNumber, this.verifyCode) // 判断验证码是否正确并登录
            //   this.loginEnable = result.loginEnable
            //   if (this.loginEnable) {
            //     promptAction.showToast({
            //       message: '正在获取数据',
            //       duration: 2000
            //     })
            //     this.airData = await Air.getDataArr()
            //     this.soilData = await Soil.getDataArr()
            //     // 登录成功跳转进入主页
            //     router.replaceUrl({
            //       url: 'pages/index'
            //     }).then(() => {
            //       // 登录成功弹窗
            //       promptAction.showToast({
            //         message: '登录成功',
            //         duration: 2000
            //       })
            //     })
            //   }
            //
            // }
            () => {
              router.pushUrl({
                url:'pages/index'
              })
            }
          )

        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.login_background'))
    .backgroundImageSize(ImageSize.Cover)
  }
}