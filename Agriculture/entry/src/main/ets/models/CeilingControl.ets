import http from '@ohos.net.http';

export class CeilingControl {
  private static url = 'http://189.1.245.236:8000/controll/ceiling/';

  /**
   * 打开棚顶
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async openCeiling(): Promise<string> {
    return this.controlCeiling(1);
  }

  /**
   * 关闭棚顶
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async closeCeiling(): Promise<string> {
    return this.controlCeiling(0);
  }

  /**
   * 控制棚顶开合的核心方法
   *
   * @param status 传入1表示打开棚顶，传入0表示关闭棚顶
   * @returns 返回一个 Promise，解析为操作结果
   */
  private static async controlCeiling(status: number): Promise<string> {
    console.log(`[CeilingControl] 函数开始执行，status: ${status}`);

    return new Promise((resolve, reject) => {
      const request = http.createHttp();
      console.log('[CeilingControl] 发起请求');

      request.request(
        `${this.url}${status}`,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          if (err) {
            console.error('[CeilingControl] 请求失败:', JSON.stringify(err));
            reject(new Error('控制棚顶失败'));
          } else {
            try {
              const result = data.result as string;
              const parsedData = JSON.parse(result);
              console.log('[CeilingControl] 回调数据:', JSON.stringify(parsedData));

              if (parsedData.code === 0) {
                resolve('操作成功');
              } else {
                reject(new Error('操作失败: ' + parsedData.message));
              }
            } catch (error) {
              console.error('[CeilingControl] 数据解析失败:', error);
              reject(new Error('数据解析失败'));
            }
          }
        }
      );
    });
  }
}