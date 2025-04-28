import router from '@ohos.router'
import {Account} from '../common/account'

@Component
export struct settings {
  //弹窗控制器
  MessageDialogController: CustomDialogController = new CustomDialogController({
    builder: MessageDialog({
    })
  })

  @State userAccount: Account = new Account('SZTU', 'BDIer', '男', '12345677890', '4')

  build() {
    Column(){
      Column() {
        //上半部分
        Stack(){
          Column(){
            Image($r('app.media.agriculture'))
              .width('100%')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Start)
          .linearGradient({direction:GradientDirection.Bottom,colors:[['#fffff32f',0.0],['#fff',0.85],['#f0f1f5',1.0]]})

          Row(){
            Row({space:5}){
              Column() {
                Column() {
                  Image($r('app.media.BDI'))
                    .width(60)
                    .aspectRatio(1)
                    .borderRadius(30)
                    .borderWidth(5)
                    .borderColor('#d37036')
                    .margin(10)
                }

                Row(){
                  Text('开源鸿蒙智慧农业终端')
                    .fontSize(18)
                    .fontWeight(800)

                  Row() {
                    Text('个人详情')
                  }
                  .width(100)
                  .height(30)
                  .justifyContent(FlexAlign.Center)
                  .borderRadius(15)
                  .backgroundColor(Color.Yellow)
                  .onClick(() => {
                    console.log('保存成功:', JSON.stringify(this.userAccount))
                    router.pushUrl({
                      url:'pages/PersonalInformation',
                      params: {
                        userAccount: this.userAccount,
                      },
                    })
                  })

                }
                .width('100%')
                .padding(10)
                .justifyContent(FlexAlign.SpaceBetween)

                Text('让农业生产过程更智能、更高效')
                  .fontSize(18)
                  .fontWeight(800)
                  .margin({bottom:'20lpx'})
              }
              .alignItems(HorizontalAlign.Start)

            }
            .width('100%')
            .padding({left:5,right:5})
            .height(150)
          }
          .width('90%')
          .height('80%')
          .borderWidth(1)
          .borderColor('#fff')
          .alignItems(VerticalAlign.Top)
          .borderRadius({topLeft:10,topRight:10})
          .opacity(0.85)
          .linearGradient({
            angle: 180,
            colors: [['#59b0b6', 0.0], ["#fff", 1.0]]
          })

        }
        .width('100%')
        .height('40%')
        .align(Alignment.Bottom)

        //下半部分
        Column(){
          Column({space:20}) {
            Column() {

              ListItemSettings({ title: '用户信息' })
                .onClick(() => {
                  console.log('保存成功:', JSON.stringify(this.userAccount))
                  router.pushUrl({
                    url:'pages/PersonalInformation',
                    params: {
                      userAccount: this.userAccount,
                    },
                  })
                })
              ListItemSettings({ title: '用户设置' })
              ListItemSettings({ title: '退出登录' })
                .onClick(()=>{
                  this.MessageDialogController.open()
                })

              // ListIteminformation({
              //   title: '用户信息',
              //   information: this.userAccount.name,
              //   onChange: (value: string) => {
              //   this.userAccount.name = value
              //   }
              // })
              // ListIteminformation({
              //   title: '用户设置',
              //   information: this.userAccount.nickname,
              //   onChange: (value: string) => {
              //     this.userAccount.nickname = value
              //   }
              // })
              // ListIteminformation({
              //   title: '退出登录',
              //   information: this.userAccount.sex,
              //   onChange: (value: string) => {
              //     this.userAccount.sex = value
              //   }
              // })
            }
            .width('90%')
            .backgroundColor('#fff')
            .borderRadius(20)
          }
          .width('90%')
          .margin({top:20})
          .backgroundColor('#fff')
          .borderRadius(10)

        }
        .width('100%')
        .backgroundColor('#f0f1f5')
        .layoutWeight(1)
      }
      .height('100%')

    }

  }
}

@Component
struct ListItemSettings {
  private title: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(16)

      Image($r('app.media.ic_arrow'))
        .width(24)
        .fillColor(Color.Black)
        .aspectRatio(1)
    }
    .width('100%')
    .height(60)
    .padding(5)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#fff')
  }
}

@CustomDialog
export default struct MessageDialog {
  controller: CustomDialogController
  build(){
    Column() {
      Text('确定要退出当前账号吗？')
        .fontSize(20)
        .margin({ top: 20, bottom: 20 });

      Row() {
        Button('取消')
          .onClick(() => {
            this.controller.close();
          })
          .backgroundColor('#f0f0f0')
          .fontColor('#000')
          .margin({ right: 40 });

        Button('确认')
          .onClick(() => {
            this.controller.close();
            router.pushUrl({
              url: 'pages/LogIn',
            })
          })
          .backgroundColor('#ff0000')
          .fontColor('#fff')
      }
      .justifyContent(FlexAlign.SpaceBetween);
    }
    .padding(20)
    .backgroundColor('#ffffff')
    .borderRadius(10)
  }
}
