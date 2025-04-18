import { temperatureLineChart, humidityLineChart, rainLineChart } from './chart'

@Component
export struct history {
  @State index: number = 2

  build() {
    Column() {
      Row() {
        Text('历史曲线')
          .margin({ top: '2%' })
          .fontSize(AppStorage.get('DeviceType') == 'pad' ? 34 : 22)
          .textAlign(TextAlign.Start)
      }
      .width('88%')
      .height('20%')

      Row() {
        Image($r('app.media.zuojiantou'))
          .width('10%')
          .height('15%')
          .onClick(() => {
            this.index = (this.index + 2) % 3
          })

        if (this.index == 0) {
          temperatureLineChart()
            .width('75%')
            .height('60%')
            .alignSelf(ItemAlign.Start)
        } else if (this.index == 1) {
          humidityLineChart()
            .width('75%')
            .height('60%')
            .alignSelf(ItemAlign.Start)
        } else if (this.index == 2) {
          rainLineChart()
            .width('75%')
            .height('60%')
            .alignSelf(ItemAlign.Start)
        }

        Image($r('app.media.youjiantou'))
          .width('10%')
          .height('15%')
          .onClick(() => {
            this.index = (this.index + 1) % 3
          })
      }
      .width('100%')
      .height('80%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}