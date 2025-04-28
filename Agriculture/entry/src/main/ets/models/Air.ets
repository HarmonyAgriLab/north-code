import http from '@ohos.net.http';

export class AirData{
  aid: number;
  air_temp: number;
  air_humid: number;
  adevice_mac: string;
  aupload_time: Date;
}

export class Air {
  aid: number = null;
  air_temp: number = null;
  air_humid: number = null;
  adevice_mac: string = null;
  aupload_time: Date = null;

  private static url = 'http://189.1.245.236:8000/air'

  constructor(data: AirData) {
    this.aid = data.aid;
    this.air_temp = data.air_temp;
    this.air_humid = data.air_humid;
    this.adevice_mac = data.adevice_mac;
    this.aupload_time = new Date(data.aupload_time);
  }

  toString(): string{
    return `AirData { id: ${this.aid.toString()}, air_temp: ${this.air_temp.toString()}°C, air_humid: ${this.air_humid.toString()}%, device_mac: "${this.adevice_mac}", upload_time: ${formatDate(this.aupload_time)}}`;
  }

  isEmpty(): boolean {
    return (
      this.aid === null &&
        this.air_temp === null &&
        this.air_humid === null &&
        (this.adevice_mac === null || this.adevice_mac.trim() === '') &&
        this.aupload_time === null
    );
  }

  /**
   * 获取最新20条 Air 数据
   *
   * @returns 返回一个 Promise，解析为最新的 `Air` 对象数组
   */
  static async getDataArr(): Promise<Air[]> {
    console.log('[Air getDataArr] 函数开始执行');
    let arr: Air[] = [];

    return new Promise((resolve, reject) => {
      console.log('[Air getDataArr] 创建 request 对象');
      const request = http.createHttp();
      console.log('[Air getDataArr] 发起请求');
      request.request(
        Air.url,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          console.log('[Air getDataArr] 回调触发');
          if (err) {
            console.error('[Air getDataArr] 请求失败:', JSON.stringify(err));
            reject(new Error('Air getDataArr 请求失败'));
          } else {
            try {
              let result = data.result as string;
              let parsedData: AirData[] = JSON.parse(result);
              console.log("Air", JSON.stringify(parsedData))
              arr = Array.isArray(parsedData) ? parsedData.map((item: AirData) => new Air(item)) : [];
              console.log('[Air getDataArr] 解析成功，准备 resolve, 解析数据如下:', JSON.stringify(arr))
              resolve(arr);
            }catch (error) {
              console.error('Air 数据解析失败:', error);
              reject(new Error('Air 数据解析失败'));
            }

          }
        }
      );
    });

  }

  /**
   * 获取最新一条 Air 数据
   *
   * @returns 单个Air对象或null
   */
  static async getNewData(): Promise<Air | null>{
    try {
      const airData = await Air.getDataArr();
      if (airData.length > 0 && !airData[0].isEmpty()) {
        console.log('[Air getNewData] 获取成功:', JSON.stringify(airData[0]))
        return airData[0];
      } else {
        console.log('[Air getNewData] 没有可用数据');
        return null;
      }
    } catch (error) {
      console.error('[Air getNewData] 获取失败:', JSON.stringify(error));
      return null;
    }
  }


}

function formatDate(date: Date): string {
  const pad = (n: number) => n.toString().padStart(2, '0');

  const year = date.getFullYear();
  const month = pad(date.getMonth() + 1);
  const day = pad(date.getDate());

  const hours = pad(date.getHours());
  const minutes = pad(date.getMinutes());
  const seconds = pad(date.getSeconds());

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

