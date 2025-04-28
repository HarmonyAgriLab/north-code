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
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width(25)
          .aspectRatio(1)
          .onClick(() => router.back())
          .position({ x: 15, y: 17 })
        Text('个人详情')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .align(Alignment.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#fff')
      .justifyContent(FlexAlign.Center)
      .borderWidth({bottom:1})
      .borderColor('#f4f4f4')

      Scroll() {
        Column({ space: 50 }) {
          Column() {
            ListItemSettings({ title: '头像'})
            ListItemSettings({ title: '姓名', information: '张三丰' })
            ListItemSettings({ title: '性别', information: '男' })
            ListItemSettings({ title: '学号', information: '114514910' })
            ListItemSettings({ title: '联系方式', information: '520****1314' })

          }
          .width('100%')
          .height('100%')
          .backgroundColor('#fff')
          .borderRadius(20)

        }
      }
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .height('100%')
      .width('100%')
      .backgroundColor('#ff6cae7a')
    }
  }
}


@Component
struct ListItemSettings {
  private title: string = ''
  private information: string | Resource = ''

  build() {
    Row() {
      Text(this.title)
        .fontSize(16)

      if (this.title == '头像') {
        Image($r('app.media.BDI'))
          .width(40)
          .aspectRatio(1)
          .borderRadius(20)
          .borderWidth(2)
          .borderColor('#d37036')
      } else {
        Text(this.information)
          .fontSize(16)
          .textAlign(TextAlign.End) // 关键修改：文本右对齐
          .layoutWeight(1) // 占据剩余空间
      }
    }
    .width('100%')
    .height(60)
    .padding({left:20, right:20})
    .borderWidth({bottom:1})
    .borderColor('#f4f4f4')
    .justifyContent(FlexAlign.SpaceBetween)
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
    }
    .width('100%')
    .borderWidth({top:1})
    .borderColor('#ffe7dede')
    .padding({left:10,right:10})
  }
}
