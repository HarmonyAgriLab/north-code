import http from '@ohos.net.http';
import { BusinessError } from '@ohos.base';
import { data } from './data'

function resolveDate(date: string): string {
  let resultDate: string
  let splitDate: string[] = date.split('-')
  resultDate = `${splitDate[1]}/${splitDate[2]}`
  return resultDate
}

class Http {
  httpRequest: http.HttpRequest
  requestedId: string
  requestedWeather: data[]

  constructor() {
    this.httpRequest = http.createHttp()
    this.requestedId = ''
    this.requestedWeather = []
  }

  async requestWeather(weather7dUrl: string, weatherNowUrl: string) {
    this.requestedWeather = []
    let promise1 = await this.httpRequest.request(
      weather7dUrl,
      {
        method: http.RequestMethod.GET,
        header: [{ 'content-type': 'application/json' }]
      }
    )
    if (promise1) {
      console.log('1111111 ', weather7dUrl)
      let json: object = JSON.parse(promise1.result.toString())
      let dailyArray: object[] = json['daily']
      console.log('1111111 ' + JSON.stringify(dailyArray))
      for (let i = 0; i < 7; i++) {
        let temp: data = {
          date: '2024/9/28',
          nowTemperature: 0,
          lowTemperature: 25,
          highTemperature: 35,
          text: '晴'
        }
        if (i == 0) {
          let promise2 = await this.httpRequest.request(
            weatherNowUrl,
            {
              method: http.RequestMethod.GET,
              header: [{ 'content-type': 'application/json' }]
            }
          )
          if (promise2) {
            let json2: object = JSON.parse(promise2.result.toString())
            let now: object = json2['now']
            console.log('1111111 ' + JSON.stringify(now))
            temp.nowTemperature = now['temp']
            console.log('1111111 promise2 success')
          } else {
            console.log('1111111 promise2 fail')
          }
        }
        temp.date = resolveDate(dailyArray[i]['fxDate'])
        temp.lowTemperature = dailyArray[i]['tempMin']
        temp.highTemperature = dailyArray[i]['tempMax']
        temp.text = dailyArray[i]['textDay']
        this.requestedWeather.push(temp)
      }
      console.log('1111111 promise1 success')
    } else {
      console.log('1111111 promise1 fail')
    }
  }

  requestCityId(url: string) {
    this.requestedId = ''
    let promise = this.httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: [{ 'content-type': 'application/json' }]
      }
    )
    promise.then((response: http.HttpResponse) => {
      console.log('1111111 ', url)
      let json: object = JSON.parse(response.result.toString())
      console.log('1111111 ' + json['location'][0]['id'])
      console.log('1111111 success')
      this.requestedId = json['location'][0]['id']
    })
      .catch((err: BusinessError) => {
        console.log("1111111 error")
      })
  }
}

export default new Http()