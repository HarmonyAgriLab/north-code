import http from '@ohos.net.http';

export class HeaterControl {
  private static url = 'http://189.1.245.236:8000/controll/heater/';

  /**
   * 打开地暖
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async openHeater(): Promise<string> {
    return this.controlHeater(1);
  }

  /**
   * 关闭地暖
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async closeHeater(): Promise<string> {
    return this.controlHeater(0);
  }

  /**
   * 控制地暖开关的核心方法
   *
   * @param status 传入1表示打开地暖，传入0表示关闭地暖
   * @returns 返回一个 Promise，解析为操作结果
   */
  private static async controlHeater(status: number): Promise<string> {
    console.log(`[HeaterControl] 函数开始执行，status: ${status}`);

    return new Promise((resolve, reject) => {
      const request = http.createHttp();
      console.log('[HeaterControl] 发起请求');

      request.request(
        `${this.url}${status}`,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          if (err) {
            console.error('[HeaterControl] 请求失败:', JSON.stringify(err));
            reject(new Error('控制地暖失败'));
          } else {
            try {
              const result = data.result as string;
              const parsedData = JSON.parse(result);
              console.log('[HeaterControl] 回调数据:', JSON.stringify(parsedData));

              if (parsedData.code === 0) {
                resolve('操作成功');
              } else {
                reject(new Error('操作失败: ' + parsedData.message));
              }
            } catch (error) {
              console.error('[HeaterControl] 数据解析失败:', error);
              reject(new Error('数据解析失败'));
            }
          }
        }
      );
    });
  }
}
