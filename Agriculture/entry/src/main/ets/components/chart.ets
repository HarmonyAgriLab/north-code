import { LiteChart } from 'lite_chart'

// 温度折线图
@Component
export struct temperatureLineChart {
  @State linesDatas: number[] = [25, 30, 27, 29, 26];

  build() {
    Column() {
      Text("温度")
        .fontSize(18)
        .margin({ bottom: '5%' })

      LiteChart({
        values: $linesDatas,
        axisStyle: "#ff8fc6b0", // 坐标轴颜色
        // linesStyle: "#ffa1ffff", // 折线图
        graphStyle: "#ff61d0d4", // 曲线图
        histogramStyle: "#ffe0de4b" // x柱状图
        // barChartStyle: "#ffe0de4b", // y柱状图
      })
        .backgroundColor("#4999")
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// 湿度折线图
@Component
export struct humidityLineChart {
  @State linesDatas: number[] = [50, 75, 70, 60, 80];

  build() {
    Column() {
      Text("湿度")
        .fontSize(18)
        .margin({ bottom: '5%' })

      LiteChart({
        values: $linesDatas,
        axisStyle: "#ff8fc6b0", // 坐标轴颜色
        // linesStyle: "#ffa1ffff", // 折线图
        graphStyle: "#fff185da", // 曲线图
        histogramStyle: "#ffe0de4b" // x柱状图
        // barChartStyle: "#ffe0de4b", // y柱状图
      })
        .backgroundColor("#4999")
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// 降雨量折线图
@Component
export struct rainLineChart {
  @State linesDatas: number[] = [50, 70, 30, 90, 60];

  build() {
    Column() {
      Text("降雨量")
        .fontSize(18)
        .margin({ bottom: '5%' })

      LiteChart({
        values: $linesDatas,
        axisStyle: "#ff8fc6b0", // 坐标轴颜色
        // linesStyle: "#ffa1ffff", // 折线图
        graphStyle: "#ff5b62e2", // 曲线图
        histogramStyle: "#ffe0de4b" // x柱状图
        // barChartStyle: "#ffe0de4b", // y柱状图
      })
        .backgroundColor("#4999")
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}