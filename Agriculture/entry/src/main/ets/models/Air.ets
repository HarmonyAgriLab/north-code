import http from '@ohos.net.http';

export class Air {
  id: number;
  air_temp: number;
  air_humid: number;
  device_mac: string
  upload_time: Date;

  private static url = 'http://189.1.245.236:8000/air'

  constructor(data: any) {
    this.id = data.id;
    this.air_temp = data.air_temp;
    this.air_humid = data.air_humid;
    this.device_mac = data.device_mac;
    this.upload_time = new Date(data.upload_time);
  }

  /**
   * 获取最新20条 Air 数据
   *
   * @returns 返回一个 Promise，解析为最新的 `Air` 对象数组
   */
  static async getDataArr(): Promise<Air[]> {
    let arr = [];

    return new Promise((resolve, reject) => {
      const request = http.createHttp();
      request.request(
        Air.url,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          if (err) {
            console.error('Arr getDataArr err:', err);
            reject(new Error('Arr getDataArr 请求失败'));
          } else {
            try {
              let result = data.result as string;
              let parsedData = JSON.parse(result);
              arr = Array.isArray(data) ? parsedData.map((item: any) => {new Air(item)}) : [];
              console.log('Arr getDataArr suc data: ', arr.toString())
              resolve(arr);
            }catch (error) {
              console.error('Arr 数据解析失败:', error);
              reject(new Error('Arr 数据解析失败'));
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
      if (airData.length > 0) {
        console.log('Arr getNewData suc data: ', airData[0].toString())
        return airData[0];
      } else {
        console.log('没有可用的 Air 数据');
        return null;
      }
    } catch (error) {
      console.error('Arr getNewData err:', error);
      return null;
    }
  }


}