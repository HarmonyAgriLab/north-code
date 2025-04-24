import relationalStore from '@ohos.data.relationalStore';
import {Air, AirData} from '../../models/Air'
import {Soil, SoilData} from '../../models/Soil'


export default class RdbUtils {
  private static rdbStore: relationalStore.RdbStore;

  // 初始化
  static setStore(store: relationalStore.RdbStore) {
    RdbUtils.rdbStore = store;
  }
  static getStore(): relationalStore.RdbStore {
    return RdbUtils.rdbStore;
  }

  // 创建表
  static executeSql(sql: string): Promise<void> {
    return RdbUtils.getStore().executeSql(sql);
  }

  // 插入数据
  static insert(tableName: string, data: any): Promise<number> {
    return RdbUtils.getStore().insert(tableName, data);
  }

  // 查询并且加载空气表所有信息
  static queryAllAir(): Promise<Array<Air>> {
    let predicates = new relationalStore.RdbPredicates('Air')
    return new Promise<Array<Air>>((resolve, reject) => {
      RdbUtils.getStore().query(predicates).then((result) => {
        let airList = new Array<Air>()
        while (result.goToNextRow()) {
          // 从数据库读取原始数据
          const rawData:AirData = {
            aid: result.getLong(result.getColumnIndex("aid")),
            air_temp: result.getDouble(result.getColumnIndex("air_temp")),
            air_humid: result.getDouble(result.getColumnIndex("air_humid")),
            adevice_mac: result.getString(result.getColumnIndex("adevice_mac")),
            aupload_time: new Date(result.getString(result.getColumnIndex("aupload_time")))
          }

          // 通过构造函数创建 Air 对象，自动转换日期
          const air = new Air(rawData)
          airList.push(air)
        }
        resolve(airList)
      }).catch((error) => {
        reject(error)
      })
    })
  }

  // 具体查询空气表信息
  static queryAir(columns: string[], full_sql_text: string): Promise<Array<Air>> {
    return new Promise<Array<Air>>((resolve, reject) => {
      RdbUtils.getStore().querySql(full_sql_text).then((result) => {
        let airList = new Array<Air>()
        while (result.goToNextRow()) {
          // 从数据库读取原始数据
          let rawData: any = {}

          // 处理通配符 * 查询
          if (columns[0].includes('*')) {
            rawData = {
              aid: result.getLong(result.getColumnIndex("aid")),
              air_temp: result.getDouble(result.getColumnIndex("air_temp")),
              air_humid: result.getDouble(result.getColumnIndex("air_humid")),
              adevice_mac: result.getString(result.getColumnIndex("adevice_mac")),
              aupload_time: new Date(result.getString(result.getColumnIndex("aupload_time"))) // 字符串转Date
            }
          }
          // 处理指定列查询
          else {
            for (const col of columns) {
              if (col === 'aid') {
                rawData.aid = result.getLong(result.getColumnIndex("aid"))
              } else if (col === 'air_temp') {
                rawData.air_temp = result.getDouble(result.getColumnIndex("air_temp"))
              } else if (col === 'air_humid') {
                rawData.air_humid = result.getDouble(result.getColumnIndex("air_humid"))
              } else if (col === 'adevice_mac') {
                rawData.adevice_mac = result.getString(result.getColumnIndex("adevice_mac"))
              } else if (col === 'aupload_time') {
                rawData.aupload_time = new Date(result.getString(result.getColumnIndex("aupload_time"))) // 字符串转Date
              }
            }
          }

          const air = new Air(rawData)
          airList.push(air)
        }
        resolve(airList)
      }).catch((error) => {
        reject(error)
      })
    })
  }

  // 查询并加载土壤表所有信息
  static queryAllSoil(): Promise<Array<Soil>> {
    let predicates = new relationalStore.RdbPredicates('Soil')
    return new Promise<Array<Soil>>((resolve, reject) => {
      RdbUtils.getStore().query(predicates).then((result) => {
        let soilList = new Array<Soil>()
        while (result.goToNextRow()) {
          // 从数据库读取原始数据
          const rawData: SoilData = {
            sid: result.getLong(result.getColumnIndex("sid")),
            moisture_value: result.getDouble(result.getColumnIndex("moisture_value")),
            temperature_value: result.getDouble(result.getColumnIndex("temperature_value")),
            conductivity_value: result.getDouble(result.getColumnIndex("conductivity_value")),
            pH_value: result.getDouble(result.getColumnIndex("pH_value")),
            nitrogen: result.getDouble(result.getColumnIndex("nitrogen")),
            phosphorus: result.getDouble(result.getColumnIndex("phosphorus")),
            potassium: result.getDouble(result.getColumnIndex("potassium")),
            sdevice_mac: result.getString(result.getColumnIndex("sdevice_mac")),
            supload_time: new Date(result.getString(result.getColumnIndex("supload_time"))) // 字符串转Date
          }

          const soil = new Soil(rawData)
          soilList.push(soil)
        }
        resolve(soilList)
      }).catch((error) => {
        reject(error)
      })
    })
  }



  // 具体查询土壤表信息
  static querySoil(columns: string[], full_sql_text: string): Promise<Array<Soil>> {
    return new Promise<Array<Soil>>((resolve, reject) => {
      RdbUtils.getStore().querySql(full_sql_text).then((result) => {
        let soilList = new Array<Soil>()
        while (result.goToNextRow()) {
          // 从数据库读取原始数据
          let rawData: any = {}

          // 处理通配符 * 查询
          if (columns[0].includes('*')) {
            rawData = {
              sid: result.getLong(result.getColumnIndex("sid")),
              moisture_value: result.getDouble(result.getColumnIndex("moisture_value")),
              temperature_value: result.getDouble(result.getColumnIndex("temperature_value")),
              conductivity_value: result.getDouble(result.getColumnIndex("conductivity_value")),
              pH_value: result.getDouble(result.getColumnIndex("pH_value")),
              nitrogen: result.getDouble(result.getColumnIndex("nitrogen")),
              phosphorus: result.getDouble(result.getColumnIndex("phosphorus")),
              potassium: result.getDouble(result.getColumnIndex("potassium")),
              sdevice_mac: result.getString(result.getColumnIndex("sdevice_mac")),
              supload_time: new Date(result.getString(result.getColumnIndex("supload_time"))) // 字符串转Date
            }
          }
          // 处理指定列查询
          else {
            for (const col of columns) {
              if (col === 'sid') {
                rawData.sid = result.getLong(result.getColumnIndex("sid"))
              } else if (col === 'moisture_value') {
                rawData.moisture_value = result.getDouble(result.getColumnIndex("moisture_value"))
              } else if (col === 'temperature_value') {
                rawData.temperature_value = result.getDouble(result.getColumnIndex("temperature_value"))
              } else if (col === 'conductivity_value') {
                rawData.conductivity_value = result.getDouble(result.getColumnIndex("conductivity_value"))
              } else if (col === 'pH_value') {
                rawData.pH_value = result.getDouble(result.getColumnIndex("pH_value"))
              } else if (col === 'nitrogen') {
                rawData.nitrogen = result.getDouble(result.getColumnIndex("nitrogen"))
              } else if (col === 'phosphorus') {
                rawData.phosphorus = result.getDouble(result.getColumnIndex("phosphorus"))
              } else if (col === 'potassium') {
                rawData.potassium = result.getDouble(result.getColumnIndex("potassium"))
              } else if (col === 'sdevice_mac') {
                rawData.sdevice_mac = result.getString(result.getColumnIndex("sdevice_mac"))
              } else if (col === 'supload_time') {
                rawData.supload_time = new Date(result.getString(result.getColumnIndex("supload_time"))) // 字符串转Date
              }
            }
          }

          // 通过构造函数自动转换日期
          const soil = new Soil(rawData)
          soilList.push(soil)
        }
        resolve(soilList)
      }).catch((error) => {
        reject(error)
      })
    })
  }

}
