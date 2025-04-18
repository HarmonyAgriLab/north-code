// 氮磷钾含量
interface Nutrient {
  nitrogen: number // 氮含量
  phosphorus: number // 磷含量
  potassium: number // 钾含量
}

// 生长监测指标
interface GrowthData {
  stage: string // 生长阶段
  health: number // 健康指数
  pest: string // 病虫害监测
  nutrient: Nutrient // 氮磷钾含量
}

@Component
export struct CropGrowth {
  @State growthData: GrowthData = {
    stage: '抽穗期',
    health: 85,
    pest: '正常',
    nutrient: {
      nitrogen: 45,
      phosphorus: 32,
      potassium: 58
    }
  }

  build() {
    Column({ space: 10 }) {
      // 标题
      Text('农作物生长监测 - 3号水稻田')
        .fontSize(AppStorage.get('DeviceType') == 'pad' ? 32 : 28)
        .fontColor('#2c3e50')
        .fontWeight(FontWeight.Bold)

      // 指标卡片
      Grid() {
        GridItem() {
          this.growthIndicator('当前生长阶段', this.growthData.stage, $r('app.media.shuidao'))
        }
        GridItem() {
          this.growthIndicator('健康指数', `${this.growthData.health}%`, $r('app.media.health'))
        }
        GridItem() {
          this.growthIndicator('病虫害监测', this.growthData.pest, $r('app.media.pest'))
        }
        GridItem() {
          this.growthIndicator('养分综合', this.nutrientStatus(), $r('app.media.NPK'))
        }
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('95%')
      .height(210)


    }
    .width('100%')
    .height('100%')
    .padding(12)
    .backgroundColor('#F5F6FA')
  }

  @Builder
  growthIndicator(title: string, value: string, icon: Resource) {
    Column({ space: 5 }) {
      Image(icon)
        .width(30)
        .height(30)

      Text(value)
        .fontSize(16)
        .fontColor('#4CAF50')

      Text(title)
        .fontSize(14)
        .fontColor('#666')
    }
    .width(180)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#10000000' })
  }

  private nutrientStatus(): string {
    const levels = [
      this.growthData.nutrient.nitrogen > 40 ? '高' : '低',
      this.growthData.nutrient.phosphorus > 30 ? '正常' : '不足',
      this.growthData.nutrient.potassium > 50 ? '充足' : '正常'
    ]
    return `氮${levels[0]} 磷${levels[1]} 钾${levels[2]}`
  }
}
