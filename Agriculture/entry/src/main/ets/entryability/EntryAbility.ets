import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { initialize } from '@hw-agconnect/hmcore';
import util from '@ohos.util';
import { async } from '@hw-agconnect/cloud/src/main/ets/storage/upload/task';
import relationalStore from '@ohos.data.relationalStore'; // 导入模块
import RdbUtils from '../common/rdbUtils/RdbUtils';

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    let input = await this.context.resourceManager.getRawFileContent('agconnect-services.json');
    let jsonString = util.TextDecoder.create('utf-8', {
      ignoreBOM: true
    }).decodeWithStream(input, {
      stream: false
    });
    initialize(this.context, JSON.parse(jsonString));

    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {

    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    let windowObj = await windowStage.getMainWindow()
    let windowRect = windowObj.getWindowProperties().windowRect
    let windowRatio = windowRect.width / windowRect.height
    console.log('1111111 ', `宽：${windowRect.width}，高：${windowRect.height}`)
    AppStorage.setOrCreate('DeviceType', windowRatio >= 1 ? 'pad' : 'phone')
    console.log('1111111 ',`设备类型：${AppStorage.get('DeviceType')}`)

    windowStage.loadContent('pages/LogIn', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

    const STORE_CONFIG = {
      name: 'RdbTest.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S1 // 数据库安全级别
    };

    relationalStore.getRdbStore(this.context, STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`Succeeded in getting RdbStore.`);
      //保存store, 方便后面我们对数据库的操作
      RdbUtils.setStore(store)

    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
