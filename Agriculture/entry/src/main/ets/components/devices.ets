import { BreakpointKey, BreakpointSystem, BreakPointType } from '../common/breakpointsystem'

@Preview
@Component
export struct devices {
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

  build() {
    Column({space: this.currentBreakpoint == 'lg' ? 50 : 10}) {
      List({
        // 设置不同断点的值，然后通过getValue 结合断点来获取即可
        space: new BreakPointType({
          sm: 20,
          md: 36,
          lg: 10
        }).getValue(this.currentBreakpoint)
      }) {
        ListItem() {
          Column({ space: 10 }) {
            Text("西北区土壤湿度检测器")
              .fontSize(25)
              .alignSelf(ItemAlign.Start)
              .padding({left: 10})
            Image($r('app.media.soil'))
              .width(95)
            this.myText("土壤湿度: 42.1%")
            this.myText("土壤pH值: 6.8")
            this.myText("土壤状况: 缺水")

          }
          .width(320)
          .height(300)
          .borderRadius(10)
          .justifyContent(FlexAlign.SpaceEvenly)
          .backgroundColor("#ffc6c8ca")
          .opacity(0.8)
          .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
        }

        ListItem() {
          Column({ space: 10 }) {
            Text("西北区水阀")
              .fontSize(25)
              .alignSelf(ItemAlign.Start)
              .padding({left: 10})
            Progress({
              value: 25,
              total: 85,
              type: ProgressType.Ring,
            })
              .width(100)
              .color('#ff30a7f1')
              .backgroundColor(Color.White)
              .style({ strokeWidth: 17})
            this.myText("阀门使能: 开")
            this.myText("电压异常: 正常")
            this.myText("阀门状况: 正常")

          }
          .width(320)
          .height(300)
          .borderRadius(10)
          .justifyContent(FlexAlign.SpaceEvenly)
          .backgroundColor("#ffc6c8ca")
          .opacity(0.8)
          .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
        }

        ListItem() {
          Column({ space: 10 }) {
            Text("照明设备1")
              .fontSize(25)
              .alignSelf(ItemAlign.Start)
              .padding({left: 10})
            Image($r('app.media.linw'))
              .width(95)
            this.myText("设备电压: 121V")
            this.myText("设备使能: 开")
            this.myText("土壤状况: 电压过低")

          }
          .width(320)
          .height(300)
          .borderRadius(10)
          .justifyContent(FlexAlign.SpaceEvenly)
          .backgroundColor("#ffe2e2ac")
          .opacity(0.8)
          .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
        }

        ListItem() {
          Column({ space: 10 }) {
            Text("照明设备2")
              .fontSize(25)
              .alignSelf(ItemAlign.Start)
              .padding({left: 10})
            Image($r('app.media.linw'))
              .width(95)
            this.myText("设备电压: 217V")
            this.myText("设备使能: 开")
            this.myText("土壤状况: 正常")

          }
          .width(320)
          .height(300)
          .borderRadius(10)
          .justifyContent(FlexAlign.SpaceEvenly)
          .backgroundColor("#ffe2e2ac")
          .opacity(0.8)
          .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
        }
      }
      .alignListItem(ListItemAlign.Center)
      .lanes(this.currentBreakpoint == 'sm' ? 1 : 2, 3)
      .listDirection(Axis.Vertical)
      .scrollBar(BarState.On)
      .width('100%')
      .height('95%')
      // Row({space: this.currentBreakpoint == 'lg' ? 50 : 10}) {
      //   Column({ space: 10 }) {
      //     Text("西北区土壤湿度检测器")
      //       .fontSize(25)
      //       .alignSelf(ItemAlign.Start)
      //       .padding({left: 10})
      //     Image($r('app.media.soil'))
      //       .width(95)
      //     this.myText("土壤湿度: 42.1%")
      //     this.myText("土壤pH值: 6.8")
      //     this.myText("土壤状况: 缺水")
      //
      //   }
      //   .width(320)
      //   .height(300)
      //   .borderRadius(10)
      //   .justifyContent(FlexAlign.SpaceEvenly)
      //   .backgroundColor("#ffc6c8ca")
      //   .opacity(0.8)
      //   .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
      //
      //   Column({ space: 10 }) {
      //     Text("西北区水阀")
      //       .fontSize(25)
      //       .alignSelf(ItemAlign.Start)
      //       .padding({left: 10})
      //     Progress({
      //       value: 25,
      //       total: 85,
      //       type: ProgressType.Ring,
      //     })
      //       .width(100)
      //       .color('#ff30a7f1')
      //       .backgroundColor(Color.White)
      //       .style({ strokeWidth: 17})
      //     this.myText("阀门使能: 开")
      //     this.myText("电压异常: 正常")
      //     this.myText("阀门状况: 正常")
      //
      //   }
      //   .width(320)
      //   .height(300)
      //   .borderRadius(10)
      //   .justifyContent(FlexAlign.SpaceEvenly)
      //   .backgroundColor("#ffc6c8ca")
      //   .opacity(0.8)
      //   .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
      //
      // }
      //
      // Row({space: 50}) {
      //   Column({ space: 10 }) {
      //     Text("照明设备1")
      //       .fontSize(25)
      //       .alignSelf(ItemAlign.Start)
      //       .padding({left: 10})
      //     Image($r('app.media.linw'))
      //       .width(95)
      //     this.myText("设备电压: 121V")
      //     this.myText("设备使能: 开")
      //     this.myText("土壤状况: 电压过低")
      //
      //   }
      //   .width(320)
      //   .height(300)
      //   .borderRadius(10)
      //   .justifyContent(FlexAlign.SpaceEvenly)
      //   .backgroundColor("#ffe2e2ac")
      //   .opacity(0.8)
      //   .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
      //
      //   Column({ space: 10 }) {
      //     Text("照明设备2")
      //       .fontSize(25)
      //       .alignSelf(ItemAlign.Start)
      //       .padding({left: 10})
      //     Image($r('app.media.linw'))
      //       .width(95)
      //     this.myText("设备电压: 217V")
      //     this.myText("设备使能: 开")
      //     this.myText("土壤状况: 正常")
      //
      //   }
      //   .width(320)
      //   .height(300)
      //   .borderRadius(10)
      //   .justifyContent(FlexAlign.SpaceEvenly)
      //   .backgroundColor("#ffe2e2ac")
      //   .opacity(0.8)
      //   .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
      //
      // }
    }
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('#6bae79')
  }

  @Builder
  myText(text: string){
    Row() {
      Text(text)
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
    }
    .width(280)
    .height(45)
    .backgroundColor('#ffffffff')
    .justifyContent(FlexAlign.Center)
    .borderRadius(15)
    .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
  }
}


@Component
struct device{
  img: ResourceStr = ""
  text: string = ""

  build(){
    Column(){
      Image(this.img)
        .width(50)
      Text(this.text)
        .fontSize(25)
    }
    .margin(20)
    .width("30%")
    .height("40%")
    .borderRadius(10)
    .backgroundColor("#f1f2f3")
    .opacity(0.8)
  }
}