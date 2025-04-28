import http from '@ohos.net.http';

export class SoilData {
  sid: number;
  moisture_value: number;
  temperature_value: number;
  conductivity_value: number;
  pH_value: number;
  nitrogen: number;
  phosphorus: number;
  potassium: number;
  sdevice_mac: string;
  supload_time: Date;
}

@Observed
export class Soil {
  sid: number = null;
  moisture_value: number = null;
  temperature_value: number = null;
  conductivity_value: number = null;
  pH_value: number = null;
  nitrogen: number = null;
  phosphorus: number = null;
  potassium: number = null;
  sdevice_mac: string = null;
  supload_time: Date = null;

  private static url = 'http://189.1.245.236:8000/soil';

  constructor(data: SoilData) {
    this.sid = data.sid;
    this.moisture_value = data.moisture_value;
    this.temperature_value = data.temperature_value;
    this.conductivity_value = data.conductivity_value;
    this.pH_value = data.pH_value;
    this.nitrogen = data.nitrogen;
    this.phosphorus = data.phosphorus;
    this.potassium = data.potassium;
    this.sdevice_mac = data.sdevice_mac;
    this.supload_time = new Date(data.supload_time);
  }

  toString(): string {
    return `SoilData { id: ${this.sid}, moisture_value: ${this.moisture_value}, temperature_value: ${this.temperature_value}, conductivity_value: ${this.conductivity_value}, pH_value: ${this.pH_value}, nitrogen: ${this.nitrogen}, phosphorus: ${this.phosphorus}, potassium: ${this.potassium}, device_mac: "${this.sdevice_mac}", upload_time: ${formatDate(this.supload_time)} }`
  }

  isEmpty(): boolean {
    return (
      this.sid === null &&
        this.moisture_value === null &&
        this.temperature_value === null &&
        this.conductivity_value === null &&
        this.pH_value === null &&
        this.nitrogen === null &&
        this.phosphorus === null &&
        this.potassium === null &&
        (this.sdevice_mac === null || this.sdevice_mac.trim() === '') &&
        this.supload_time === null
    );
  }

  /**
   * 获取最近20条土壤数据
   *
   * @returns 返回一个 Promise，解析为土壤数据对象数组
   */
  static async getDataArr(): Promise<Soil[]> {
    console.log('[Soil getDataArr] 函数开始执行');
    let arr: Soil[] = [];

    return new Promise((resolve, reject) => {
      console.log('[Soil getDataArr] 创建 request 对象');
      const request = http.createHttp();
      console.log('[Soil getDataArr] 发起请求');
      request.request(
        Soil.url,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          console.log('[Soil getDataArr] 回调触发');
          if (err) {
            console.error('[Soil getDataArr] 请求失败:', err);
            reject(new Error('Soil getDataArr 请求失败'));
          } else {
            try {
              let result = data.result as string;
              let parsedData: SoilData[] = JSON.parse(result);
              console.log("Soil", JSON.stringify(parsedData))
              arr = Array.isArray(parsedData) ? parsedData.map((item: SoilData) => new Soil(item)) : [];
              console.log('[Soil getDataArr] 解析成功，准备 resolve, 解析数据如下:', JSON.stringify(arr))
              resolve(arr);
            } catch (error) {
              console.error('[Soil getDataArr] 数据解析失败:', error);
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
      if (soilData.length > 0 && !soilData[0].isEmpty()) {
        console.log('[Soil getNewData] 获取成功:', JSON.stringify(soilData[0]));
        return soilData[0];
      } else {
        console.log('[Soil getNewData] 没有可用数据');
        return null;
      }
    } catch (error) {
      console.error('[Soil getNewData] 获取失败:', JSON.stringify(error));
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