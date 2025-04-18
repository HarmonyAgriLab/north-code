export interface data {
  date: string //日期
  nowTemperature: number
  lowTemperature: number
  highTemperature: number
  text: string // 天气状况
}

export interface rowData {
  date: string
  weather: string
  image: Resource
}