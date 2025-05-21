import http from '@ohos.net.http';

export class FanControl {
  private static url = 'http://189.1.245.236:8000/controll/fan/';

  /**
   * 打开排风扇
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async openFan(): Promise<string> {
    return this.controlFan(1);
  }

  /**
   * 关闭排风扇
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async closeFan(): Promise<string> {
    return this.controlFan(0);
  }

  /**
   * 控制排风扇开关的核心方法
   *
   * @param status 传入1表示打开排风扇，传入0表示关闭排风扇
   * @returns 返回一个 Promise，解析为操作结果
   */
  private static async controlFan(status: number): Promise<string> {
    console.log(`[FanControl] 函数开始执行，status: ${status}`);

    return new Promise((resolve, reject) => {
      const request = http.createHttp();
      console.log('[FanControl] 发起请求');

      request.request(
        `${this.url}${status}`,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          if (err) {
            console.error('[FanControl] 请求失败:', JSON.stringify(err));
            reject(new Error('控制排风扇失败'));
          } else {
            try {
              const result = data.result as string;
              const parsedData = JSON.parse(result);
              console.log('[FanControl] 回调数据:', JSON.stringify(parsedData));

              if (parsedData.code === 0) {
                resolve('操作成功');
              } else {
                reject(new Error('操作失败: ' + parsedData.message));
              }
            } catch (error) {
              console.error('[FanControl] 数据解析失败:', error);
              reject(new Error('数据解析失败'));
            }
          }
        }
      );
    });
  }
}

export class CurtainControl {
  private static url = 'http://189.1.245.236:8000/controll/curtain/';

  /**
   * 打开遮阳帘
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async openCurtain(): Promise<string> {
    return this.controlCurtain(1);
  }

  /**
   * 关闭遮阳帘
   *
   * @returns 返回一个 Promise，解析为操作结果
   */
  static async closeCurtain(): Promise<string> {
    return this.controlCurtain(0);
  }

  /**
   * 控制遮阳帘开闭的核心方法
   *
   * @param status 传入1表示打开遮阳帘，传入0表示关闭遮阳帘
   * @returns 返回一个 Promise，解析为操作结果
   */
  private static async controlCurtain(status: number): Promise<string> {
    console.log(`[CurtainControl] 函数开始执行，status: ${status}`);

    return new Promise((resolve, reject) => {
      const request = http.createHttp();
      console.log('[CurtainControl] 发起请求');

      request.request(
        `${this.url}${status}`,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          if (err) {
            console.error('[CurtainControl] 请求失败:', JSON.stringify(err));
            reject(new Error('控制遮阳帘失败'));
          } else {
            try {
              const result = data.result as string;
              const parsedData = JSON.parse(result);
              console.log('[CurtainControl] 回调数据:', JSON.stringify(parsedData));

              if (parsedData.code === 0) {
                resolve('操作成功');
              } else {
                reject(new Error('操作失败: ' + parsedData.message));
              }
            } catch (error) {
              console.error('[CurtainControl] 数据解析失败:', error);
              reject(new Error('数据解析失败'));
            }
          }
        }
      );
    });
  }
}
