import router from '@ohos.router'
import {Account} from '../common/account'

@Entry
@Component
export struct settings {
  //弹窗控制器
  MessageDialogController: CustomDialogController = new CustomDialogController({
    builder: MessageDialog({
    })
  })

  @State isNameClean:boolean = false;
  @State isNicknameClean:boolean = false;
  @State isSexClean:boolean = false;
  @State number:number = 1;
  @State NicknameText:string = '';
  @State userAccount: Account = new Account('SZTU', 'BDIer', '男', '12345677890', '4')

  onPageShow(){
    this.userAccount = router.getParams()['userAccount'] as Account
  }

  build() {
    Scroll() {
      Column({space:80}) {
        // 顶部
        Row() {
          Row() {
            Image($r('app.media.back'))
              .width(25)
              .aspectRatio(1)
              .onClick(() => {
                router.back()
              })
          }
          .position({ x: 15, y: 17 })

          Row() {
            Text('设置')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .align(Alignment.Center)
          }
        }
        .width('100%')
        .height(60)
        .backgroundColor('#fff')
        .justifyContent(FlexAlign.Center)


        Column({ space: 50 }) {
          Column() {
            Column() {
              Text('个人信息')
                .fontSize(20)
            }
            .height(40)
            .justifyContent(FlexAlign.Center)
            .width('100%')

            // 个人信息展示为 Text
            Row() {
              Text('账号名: ')
                .width(60)
                .fontSize(16)
              Text(this.userAccount.name)
                .fontSize(16)
            }
            .width('100%')
            .borderColor('#ffe7dede')
            .padding(10)
            Row() {
              Text('昵称:     ')
              Text(this.userAccount.nickname)
                .fontSize(16)
            }
            .width('100%')
            .borderColor('#ffe7dede')
            .padding(10)
            Row() {
              Text('性别:     ')
              Text(this.userAccount.sex)
                .fontSize(16)
            }
            .width('100%')
            .borderColor('#ffe7dede')
            .padding(10)

            // ListIteminformation({
            //   title: '账号名',
            //   information: this.userAccount.name,
            //   onChange: (value: string) => {
            //   this.userAccount.name = value
            //   }
            // })
            // ListIteminformation({
            //   title: '昵称',
            //   information: this.userAccount.nickname,
            //   onChange: (value: string) => {
            //     this.userAccount.nickname = value
            //   }
            // })
            // ListIteminformation({
            //   title: '性别',
            //   information: this.userAccount.sex,
            //   onChange: (value: string) => {
            //     this.userAccount.sex = value
            //   }
            // })
          }
          .width('90%')
          .backgroundColor('#fff')
          .borderRadius(20)

          ListItemSettings({ title: '修改个人信息' })
            .onClick(() => {
              console.log('保存成功:', JSON.stringify(this.userAccount))
              router.pushUrl({
                url:'pages/PersonalInformation',
                params: {
                  userAccount: this.userAccount,
                },
              })
            })

          ListItemSettings({ title: '切换账号' })
            .onClick(() => {
              this.MessageDialogController.open()
            })

          ListItemSettings({ title: '退出登录' })
            .onClick(()=>{
              this.MessageDialogController.open()
            })
        }
      }
    }
    .align(Alignment.Top)
    .scrollBar(BarState.Off)
    .height('100%')
    .width('100%')
    .backgroundColor('#ff6cae7a')
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
    .width('90%')
    .height(50)
    .padding({left:20,right:20})
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(20)
    .backgroundColor('#fff')
  }
}

@Component
struct ListIteminformation {
  private title: string = '';
  private information: string = '';
  private number: number = 1;
  private onChange: (value: string) => void = () => {};

  build() {
    Row() {
      Text(this.title)
        .width(50)
        .fontSize(16)

      TextInput({text:this.information})
        .placeholderColor(Color.Black)
        .backgroundColor(Color.White)
        .borderRadius(0)
        .margin({right:10})
        .layoutWeight(1)

        .onChange((value: string) => {
          this.onChange(value)
        })

      // .onChange((value: string) => {
      //   if (this.number == 1) {
      //     this.userAccount.name = value
      //   } else if (this.number == 2) {
      //     this.userAccount.nickname = value
      //   } else if (this.number == 3) {
      //     this.userAccount.sex = value
      //   }
      // });

      // if(this.number == 1 && this.isNicknameClean) {
      //   Image($r('app.media.clean'))
      //     .width(24)
      //     .aspectRatio(1)
      //     .fillColor('#ccc')
      //     .onClick(()=>{
      //       this.NicknameText = ''
      //     })
      // }



    }
    .width('100%')
    .borderWidth({top:1})
    .borderColor('#ffe7dede')
    .padding({left:10,right:10})
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