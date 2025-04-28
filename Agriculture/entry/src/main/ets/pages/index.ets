import common from '@ohos.app.ability.common'
import window from '@ohos.window'
import { devices } from '../components/devices'
import { home } from "../components/home"
import { settings } from "../components/settings"
import {Environment} from "../components/environment"
import { Account } from '../common/account'
import { BreakpointKey, BreakpointSystem } from '../common/breakpointsystem'
import relationalStore from '@ohos.data.relationalStore' // 导入模块
import RdbUtils from '../common/rdbUtils/RdbUtils'
import { Air } from '../models/Air'
import { Soil } from '../models/Soil'
import { async } from '@hw-agconnect/cloud/src/main/ets/storage/upload/task'


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

  @Provide airArr: Air[] = []
  @Provide soilArr: Soil[] = []

  // 3. 注册及移除事件
  async aboutToAppear(): Promise<void> {
    this.breakpointSystem.register()
    this.initAirTable()
    this.initSoilTable()

    this.airArr = AppStorage.get('AirData')
    this.soilArr = AppStorage.get('SoilData')



    if(this.airArr.length == 0){
      this.airArr = await Air.getDataArr()
    }
    if(this.soilArr.length == 0){
      this.soilArr = await Soil.getDataArr()
    }
    console.log("aaatest", this.airArr.toString())
    console.log("aaatest", this.soilArr.toString())

  }

  aboutToDisappear(): void {
    this.breakpointSystem.unregister()
  }

  @State list1:Array<Air> = [];
  @State list2:Array<Soil> = [];

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
        .width(this.currentBreakpoint == 'lg' ? 30 : 16)

      Text(title)
        .fontSize(this.currentBreakpoint == 'lg' ? 20 : 16)
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

  initAirTable() {
    const SQL_CREATE_TABLE_Air = 'CREATE TABLE IF NOT EXISTS Air' +
      ' (AID INTEGER PRIMARY KEY, ' +
      'AIR_TEMP INTEGER, ' +
      'AIR_HUMID INTEGER, ' +
      'DEVICE_MAC TEXT NOT NULL, ' +
      'UPLOAD_TIME TEXT NOT NULL)'; // 建Air表Sql语句

    RdbUtils.executeSql(SQL_CREATE_TABLE_Air)
      .then(() =>{
        console.log('successfully created table_Air');
      }).catch((err) => {
      openDialog(err);
    })

  }

  initSoilTable() {
    const SQL_CREATE_TABLE_Soil = 'CREATE TABLE IF NOT EXISTS Soil' +
      ' (SID INTEGER PRIMARY KEY, ' +
      'MOISTURE_VALUE INTEGER, ' +
      'TEMPERATURE_VALUE INTEGER, ' +
      'CONDUCTIVITY_VALUE INTEGER, ' +
      'PH_VALUE INTEGER, ' +
      'NITROGEN INTEGER, ' +
      'PHOSPHORUS INTEGER, ' +
      'POTASSIUM INTEGER, ' +
      'SDEVICE_MAC TEXT NOT NULL, ' +
      'SUPLOAD_TIME TEXT NOT NULL)'; // 建Soil表Sql语句

    RdbUtils.executeSql(SQL_CREATE_TABLE_Soil)
      .then(() =>{
        console.log('successfully created table_Soil');
      }).catch((err) => {
      openDialog(err);
    })

  }


}

function openDialog(text: string) {
  AlertDialog.show(
    {
      title: 'title',
      message: text,
      autoCancel: true,
      alignment: DialogAlignment.Bottom,
      offset: { dx: 0, dy: -20 },
    }
  )
}

