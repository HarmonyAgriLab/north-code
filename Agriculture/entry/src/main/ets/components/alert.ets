@Component
export struct alert {
  @Builder
  alertItem(icon: Resource, level: string, content: string, time: string) {
    Row() {
      Column()
        .width(4)
        .height('70%')
        .backgroundColor(level === 'critical' ? '#ff4757' : '#ffd32a')
        .margin({ left: 8, right: 8 })

      Image(icon)
        .width(32)
        .height(32)
        .margin({ left: 8, right: 12 })

      Column({ space: 2 }) {
        Text(content)
          .fontSize(16)
          .fontColor('#2d3436')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(time)
          .fontSize(14)
          .fontColor('#636e72')
      }
      .layoutWeight(1)
    }
    .height(52)
    .padding({ right: 8 })
    .backgroundColor('#ffffff')
    .borderRadius(6)
    .shadow({ radius: 2, color: '#1f000000', offsetX: 1, offsetY: 1 })
    .margin({ top: 4, bottom: 4, left: 8, right: 8 })
  }

  build() {
    Column() {
      Row({space:15}) {
        Image($r('app.media.alarm'))
        .width(28)
        .height(28)

        Text('告警信息')
          .fontSize(24)
          .fontColor('#2d3436')
          .fontWeight(500)

      }
      .padding({ top: 4, bottom: 4 })

      Scroll() {
        Column() {
          this.alertItem($r('app.media.alert_red'), 'critical', '土壤温度异常：8°C（最低阈值15°C）', '11:47')
          this.alertItem($r('app.media.alert_yellow'), 'warning', '设备电压异常：121V（正常范围200-240V）', '11:30')
          this.alertItem($r('app.media.alert_red'), 'critical', '空气湿度过低：23%（建议>60%）', '11:05')
          this.alertItem($r('app.media.alert_yellow'), 'warning', '水泵持续运行：已超过2小时', '10:55')
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffc5e4f3')
  }
}
