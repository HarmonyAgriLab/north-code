// 生长阶段进度
interface growthstage {
  stage: string // 生长阶段
  progress: number // 进度条
  date: string
}

@Component
export struct GrowthStage {
  @State growthStages: growthstage[] = [
    { stage: '播种期', progress: 100, date: '03/01' },
    { stage: '苗期', progress: 100, date: '04/15' },
    { stage: '分蘖期', progress: 100, date: '06/01' },
    { stage: '抽穗期', progress: 65, date: '07/20' },
    { stage: '成熟期', progress: 0, date: '预计09/10' }
  ]

  build() {
    Column({ space: 10 }) {
      // 生长进度时间轴
      Column() {
        Text('生长阶段进度')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })

        ForEach(this.growthStages, (item) => {
          Row({space:20}) {
            Text(item.stage)
              .width('20%')
            Progress({ value: item.progress, total: 100 })
              .width('50%')
              .color('#4CAF50')
            Text(item.date)
              .width('20%')
              .fontColor('#666')
          }
          .padding(8)
        })
      }
      .width('105%')
      .height(276)
      .padding(12)
      .backgroundColor('#FFF')
      .borderRadius(12)
      .shadow({ radius: 4, color: '#10000000' })
    }
    .width('100%')
    .height('100%')
    .padding({ left:12, right:12 })
  }
}