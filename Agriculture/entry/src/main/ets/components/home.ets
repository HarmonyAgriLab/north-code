import { weather} from "./weather"
import { environment } from "./environment"
import { history } from './history'
import { alert } from "./alert"
import { CropGrowth } from "./CropGrowth"
import { GrowthStage } from "./GrowthStage"

@Preview
@Component
export struct home {
  tabsController: TabsController = new TabsController()

  build() {
    Column() {
      Grid() {
        GridItem() {
          // weather()
          CropGrowth()
        }
        .borderRadius(10)
        .backgroundColor(Color.Orange)
        .opacity(0.8)

        GridItem() {
          environment()
            .onClick(() => {
              this.tabsController.changeIndex(2)
            })
        }
        .borderRadius(10)
        .backgroundColor(Color.Yellow)
        .opacity(0.7)

        GridItem() {
          // history()
          GrowthStage()
        }
        .borderRadius(10)
        // .backgroundColor('#ffc5e4f3')

        GridItem() {
          alert()
            .onClick(() => {
              this.tabsController.changeIndex(1)
            })
        }
        .borderRadius(10)
        .backgroundColor(Color.Pink)
        .opacity(0.75)
      }
      .width('95%')
      .height('90%')
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap('2%')
      .rowsGap('4%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#6bae79')
    .justifyContent(FlexAlign.Center)
  }
}