import common from '@ohos.app.ability.common'
import window from '@ohos.window'
import { devices } from '../components/devices'
import { home } from "../components/home"
import { settings } from "../components/settings"
import {Environment} from "../components/environment"
import {Account} from '../common/account'
import { BreakpointKey, BreakpointSystem } from '../common/breakpointsystem'

@Entry
@Component
struct Index {
  // Tab 组件 当前选择的索引
  @State curIndex: number = 0
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


  private tabsController: TabsController = new TabsController()
  // @State userAccount: Account = new Account('SZTU', 'BDIer', '男', '12366667890', '4')

  async onPageShow() {
    let context = getContext(this) as common.UIAbilityContext
    let lastWindow: window.Window = await window.getLastWindow(context)
    if (lastWindow) {
      lastWindow.setPreferredOrientation(window.Orientation.LANDSCAPE)
    }
  }

  @Builder
  tabBuilder(index: number, title: string, icon: Resource, iconSelected: Resource) {
    Column({ space: 3 }) {
      Image(this.curIndex === index ? iconSelected : icon)
        .width(this.currentBreakpoint == 'lg' ? 40 : 16)

      Text(title)
        .fontSize(this.currentBreakpoint == 'lg' ? 30 : 16)
        .fontColor(this.curIndex === index ? '#007DFF' : '#000')

    }
    .width('100%')
    .height('50%')
  }

  build() {
    Tabs({ barPosition: this.currentBreakpoint == 'lg' ? BarPosition.Start : BarPosition.End, controller: this.tabsController }) {
      TabContent() {
        home({ tabsController: this.tabsController })
      }
      .tabBar(this.tabBuilder(0, '主页', $r('app.media.home'), $r('app.media.home_selected')))

      TabContent() {
        devices()
      }
      .tabBar(this.tabBuilder(1, '设备', $r('app.media.device'), $r('app.media.device_selected')))

      TabContent() {
        Environment()
      }
      .tabBar(this.tabBuilder(2, '环境', $r("app.media.environment"), $r("app.media.environment_selected")))

      TabContent() {
        // settings({ userAccount: $userAccount })
        settings()
      }
      .tabBar(this.tabBuilder(3, '设置', $r('app.media.user'), $r('app.media.user_selected')))
    }
    .onChange((index: number) => {
      this.curIndex = index
    })
    .width('100%')
    .height('100%')
    .vertical(this.currentBreakpoint == 'lg' ? true : false)
    .scrollable(false)
    .barWidth(this.currentBreakpoint == 'lg' ? '10%' : '100%')
    .barHeight(this.currentBreakpoint == 'lg' ? '100%' : '8%')
    .backgroundColor('#ffffffff')

  }
}