import Http from '../common/http'
import { rowData } from '../common/data'
import { weather7dUrl, weatherNowUrl } from '../constants/constants'

@Component
export struct weather {
  @State rowDatas: rowData[] = [
    { date: '12/6', weather: '晴', image: $r('app.media.sunny') }
  ]
  @State nowTemperature: number = 30
  @State lowTemperature: number = 25
  @State highTemperature: number = 35

  async aboutToAppear() {
    await Http.requestWeather(weather7dUrl, weatherNowUrl)
    if (Http.requestedWeather) {
      this.rowDatas = []
      this.nowTemperature = Http.requestedWeather[0].nowTemperature
      this.lowTemperature = Http.requestedWeather[0].lowTemperature
      this.highTemperature = Http.requestedWeather[0].highTemperature
      for (let i = 0; i < 5; i++) {
        let rowData: rowData = { date: '12/6', weather: '晴', image: $r('app.media.sunny') }
        if (Http.requestedWeather[i+1].date) {
          rowData.date = Http.requestedWeather[i+1].date
        }
        console.log('1111111 ' + rowData.date)
        if (Http.requestedWeather[i+1].text) {
          rowData.weather = Http.requestedWeather[i+1].text
        }
        console.log('1111111 ' + rowData.weather)
        switch (rowData.weather) {
          case '晴': {
            rowData.image = $r('app.media.sunny')
            console.log('1111111 in case 晴')
            break
          }
          case '多云': {
            rowData.image = $r("app.media.cloudy")
            console.log('1111111 in case 多云')
            break
          }
          case '大雨': {
            rowData.image = $r('app.media.rainy_heavily')
            console.log('1111111 in case 大雨')
            break
          }
          case '中雨': {
            rowData.image = $r('app.media.rainy')
            console.log('1111111 in case 中雨')
            break
          }
          case '小雨': {
            rowData.image = $r('app.media.rainy')
            console.log('1111111 in case 小雨')
            break
          }
          case '阵雨': {
            rowData.image = $r('app.media.rainy')
            console.log('1111111 in case 阵雨')
            break
          }
          case '晴间多云': {
            rowData.image = $r('app.media.cloudy_sunny')
            console.log('1111111 in case 晴间多云')
            break
          }
          default: {
            rowData.image = $r('app.media.sunny')
            console.log('1111111 in case default')
          }
        }
        this.rowDatas.push(rowData)
      }
    }
  }

  build() {
    Column() {
      Row() {
        Text('天气')
          .margin({ top: '2%' })
          .fontSize(AppStorage.get('DeviceType') == 'pad' ? 34 : 22)
          .textAlign(TextAlign.Start)
      }
      .width('88%')
      .height('20%')

      Row() {
        Row() {
          Column() {
            Text('连平市')
              .fontSize(AppStorage.get('DeviceType') == 'pad' ? 26 : 16)

            Text(this.nowTemperature.toString() + '℃')
              .fontSize(AppStorage.get('DeviceType') == 'pad' ? 26 : 16)
          }
          .width('46%')
          .height('100%')
          .margin({ left: '4%' })
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)

          Column() {
            Text('多云')
              .fontSize(AppStorage.get('DeviceType') == 'pad' ? 26 : 16)

            Text(this.lowTemperature.toString() + '℃-' + this.highTemperature.toString() + '℃')
              .fontSize(AppStorage.get('DeviceType') == 'pad' ? 19 : 14)
          }
          .width('46%')
          .height('100%')
          .margin({ right: '4%' })
          .justifyContent(FlexAlign.End)
        }
        .width('50%')
        .height('80%')
        // .margin({ left: '4%' })
        .borderRadius(10)
        .backgroundColor(Color.Grey)
        .opacity(0.8)

        Row() {
          Image($r('app.media.weather'))
            .width('36%')
            .margin({ left: '50%' })
            .transition({ type: TransitionType.All, scale: { x: 1.1, y: 1.1 } }) // 悬停放大

        }
        .width('50%')
        .height('100%')
      }
      .width('88%')
      .height('48%')

      Row() {
        ForEach(this.rowDatas, (rowData: rowData) => {
          Column() {
            Image(rowData.image)
              .width('65%')
              .height('65%')
            Text(rowData.date)
              .fontSize(AppStorage.get('DeviceType') == 'pad' ? 24 : 12)
          }
          .width('15%')
          .height('100%')
        })
      }
      .width('88%')
      .height('28%')
      .borderRadius(10)
      .backgroundColor(Color.Grey)
      .opacity(0.8)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}