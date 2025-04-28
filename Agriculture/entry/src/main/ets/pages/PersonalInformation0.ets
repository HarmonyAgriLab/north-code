import router from '@ohos.router'
import {Account} from '../common/account'

@Entry
@Component
export struct PeronsalInformation {
  @State userAccount:object = router.getParams()['userAccount']  as Account

  @State userAccount2:Account = router.getParams()['userAccount'] as Account

  aboutToAppear(): void {
    const params = router.getParams()['userAccount'] as Account
  }

  @State isNameClean:boolean = false;
  @State isNicknameClean:boolean = false;
  @State isSexClean:boolean = false;
  @State number:number = 1;
  @State NicknameText:string = '';
  //@Link userAccount: Account


  build() {
    Scroll() {
      Column({space:80}) {
        // 顶部
        // Row() {
        //   Row() {
        //     Image($r('app.media.back'))
        //       .width(25)
        //       .aspectRatio(1)
        //       .onClick(() => {
        //         router.back()
        //       })
        //   }
        //   .position({ x: 15, y: 17 })
        //
        //   Row() {
        //     Text('设置')
        //       .fontSize(25)
        //       .fontWeight(FontWeight.Bold)
        //       .align(Alignment.Center)
        //   }
        // }
        // .width('100%')
        // .height(60)
        // .backgroundColor('#fff')
        // .justifyContent(FlexAlign.Center)

        Row() {
          Image($r('app.media.back'))
            .width(25)
            .aspectRatio(1)
            .onClick(() => router.back())
            .position({ x: 15, y: 17 })
          Text('修改个人信息')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .align(Alignment.Center)
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

            // ListIteminformation({
            //   title: '账号名',
            //   information: this.userAccount.name,
            //   onChange: (value: string) => {
            //     this.userAccount.name = value
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

            // 修改信息输入框
            TextInput({ text: this.userAccount['name'] })
              .onChange((value: string) => {
                this.userAccount['name'] = value
              })

            TextInput({ text: this.userAccount['nickname'] })
              .onChange((value: string) => {
                this.userAccount['nickname'] = value
              })

            TextInput({ text: this.userAccount['sex'] })
              .onChange((value: string) => {
                this.userAccount['sex'] = value
              })

          }
          .width('90%')
          .backgroundColor('#fff')
          .borderRadius(20)

          // 确认按钮
          Button('确认')
            .onClick(() => {
              console.log('修改信息已保存:', JSON.stringify(this.userAccount))
              router.back({
                url:'',
                params: {
                  userAccount: this.userAccount,
                }
              })
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
  @Link userAccount: Account

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