import http from '@ohos.net.http';

export class Soil {
  id: number;
  moisture_value: number;
  temperature_value: number;
  conductivity_value: number;
  pH_value: number;
  nitrogen: number;
  phosphorus: number;
  potassium: number;
  device_mac: string;
  upload_time: Date;

  private static url = 'http://189.1.245.236:8000/soil';

  constructor(data: any) {
    this.id = data.id;
    this.moisture_value = data.moisture_value;
    this.temperature_value = data.temperature_value;
    this.conductivity_value = data.conductivity_value;
    this.pH_value = data.pH_value;
    this.nitrogen = data.nitrogen;
    this.phosphorus = data.phosphorus;
    this.potassium = data.potassium;
    this.device_mac = data.device_mac;
    this.upload_time = new Date(data.upload_time);
  }

  /**
   * 获取最近20条土壤数据
   *
   * @returns 返回一个 Promise，解析为土壤数据对象数组
   */
  static async getDataArr(): Promise<Soil[]> {
    let arr: Soil[] = [];

    return new Promise((resolve, reject) => {
      const request = http.createHttp();
      request.request(
        Soil.url,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          if (err) {
            console.error('Soil getDataArr err:', err);
            reject(new Error('Soil getDataArr 请求失败'));
          } else {
            try {
              let result = data.result as string;
              let parsedData = JSON.parse(result);
              arr = Array.isArray(parsedData) ? parsedData.map((item: any) => new Soil(item)) : [];
              console.log('Soil getDataArr suc data: ', arr);
              resolve(arr);
            } catch (error) {
              console.error('Soil 数据解析失败:', error);
              reject(new Error('Soil 数据解析失败'));
            }
          }
        }
      );
    });
  }

  /**
   * 获取最新一条土壤数据
   *
   * @returns 返回最新的土壤数据对象或 null
   */
  static async getNewData(): Promise<Soil | null> {
    try {
      const soilData = await Soil.getDataArr();
      if (soilData.length > 0) {
        console.log('Soil getNewData suc data: ', soilData[0]);
        return soilData[0];
      } else {
        console.log('没有可用的土壤数据');
        return null;
      }
    } catch (error) {
      console.error('Soil getNewData err:', error);
      return null;
    }
  }
}