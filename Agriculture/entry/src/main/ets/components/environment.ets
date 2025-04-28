import { ImageFetcher } from '../models/ImageFetcher';
import { Air } from '../models/Air'
import { BreakpointKey, BreakpointSystem, BreakPointType } from '../common/breakpointsystem'
import { Soil } from '../models/Soil';
import { ObjectWrapper } from '@hw-agconnect/cloud/src/main/ets/database/sync/ObjectWrapper';

@Component
export struct environment {
  // 1. 引入 AppStorage 中保存的断点值
  @StorageLink(BreakpointKey)
  currentBreakpoint: string = 'lg'
  // 2. 实例化 BreakpointSystem对象
  breakpointSystem: BreakpointSystem = new BreakpointSystem()

  @Consume airArr: Air[]
  @Consume soilArr: Soil[]



  // 3. 注册及移除事件
  async aboutToAppear(): Promise<void> {
    this.breakpointSystem.register()
  }

  aboutToDisappear(): void {
    this.breakpointSystem.unregister()
  }

  build() {
    Column() {
      Text('环境参数')
        .fontSize(this.currentBreakpoint == 'lg' ? 28 : 20)
        .fontColor('#2c3e50')
        .fontWeight(FontWeight.Bold)
        .margin({ top: 15, bottom: 10 })

      Grid() {
        GridItem() {
          this.dataItem('大棚温度', this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].temperature_value.toString() : '23°C', '#e74c3c')
        }
        GridItem() {
          this.dataItem('大棚湿度', (this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].moisture_value.toString() : '74') + '%', '#3498db')
        }
        GridItem() {
          this.dataItem('土壤PH值', this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].pH_value.toString() : '7.1', '#2ecc71')
        }
        GridItem() {
          this.dataItem('土壤导电率', (this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].conductivity_value.toString() : '52') + '%', '#9b59b6')
        }
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('90%')
      .height('60%')
    }
    .width('100%')
    .height('100%')
    .borderRadius(12)
    .backgroundColor('#ffc5e4f3')
  }

  @Builder
  dataItem(title: string, value: string, color: string) {
    Column({ space: 6 }) {
      Text(value)
        .fontSize(this.currentBreakpoint == 'lg' ? 15 : 15)

        .fontColor('#ffffff')
        .fontWeight(FontWeight.Bold)

      Text(title)
        .fontSize(this.currentBreakpoint == 'lg' ? 10 : 10)
        .fontColor('#ffffffcc')
    }
    .width('100%')
    .height('100%')
    .padding(8)
    .backgroundColor(color)
    .borderRadius(36)
    .shadow({
      radius: 6,
      color: '#30000000',
      offsetX: 4,
      offsetY: 4
    })
  }
}

@Component
export struct Environment {
  @State fontColor: string = '#fffff'
  @State selectedFontColor: string = '#007DFF'
  @State curIndex: number = 0

  @Consume airArr: Air[]
  @Consume soilArr: Soil[]

  @Builder tabBuilder(index: number, title: string) {
    Column() {
      Text(title)
        .fontSize(this.curIndex === index ? 35 : 30)
        .fontColor(this.curIndex === index ? '#007DFF' : '#fff')
        .fontWeight(this.curIndex === index ? 600 : 400)
        .lineHeight(40)
        .padding({ left: 10, right: 5 })
        // .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(3)
        .width(140)
        .color('#007DFF')
        .opacity(this.curIndex === index ? 1 : 0)
    }
    .borderWidth({bottom:1 })
    .borderColor(Color.Gray)
    .width('100%')
    .height(50)
  }

  //弹窗控制器
  MessageDialogController: CustomDialogController = new CustomDialogController({
    builder: MessageDialog({
    }),
    autoCancel: true,
    offset: { dx: 0, dy: -20 },
    customStyle: true,
    cornerRadius: 100,
  })

  build() {
    Column({space: 50}) {
      Tabs() {
        TabContent() {
          Column({space: 20}) {
            Column() {
              Text('当前土壤')
                .fontSize(26)
                .fontColor(Color.Brown)
                .fontWeight(FontWeight.Bolder)
              Text('3号水稻地')
                .fontSize(26)
                .fontColor(Color.Brown)
                .fontWeight(FontWeight.Bolder)
            }
            .position({ x: '70%', y: '15%' })

            Column() {
              Text('当前天气')
                .fontSize(32)
                .fontColor(Color.Yellow)
                .fontWeight(FontWeight.Bolder)
            }
            .position({ x: '10%', y: '25%' })

            // 天气模块
            Column() {
              Text("温度：" + '13.3℃' )
                .fontSize(30)
                .fontColor(Color.White)
                .margin({ bottom: 15 })

              Row({ space: 25 }) {
                Image($r("app.media.cloudy"))
                  .width(40)
                  .height(40)
                  .objectFit(ImageFit.Contain)

                Text("多云")
                  .fontSize(26)
                  .fontColor(Color.White)
              }
            }
            .width(180)
            .height(180)
            .justifyContent(FlexAlign.Center)
            .backgroundColor("#1f7e3e")
            .borderRadius(999)
            .shadow({
              radius: 15,
              color: Color.Black,
              offsetX: 3,
              offsetY: 3,
            })
            .onClick(() => {
              this.MessageDialogController.open()
            })
            .position({ x: '5%', y: '35%' })
            .zIndex(3)

            Column() {
              Text('大棚室内温度')
                .fontSize(32)
                .fontColor('#ebc594')
                .fontWeight(FontWeight.Bolder)
            }
            .position({ x: '35%', y: '1%' })

            // 大棚空气温度
            Column({space:15}) {
              // 第一行：标题+数值
              Row({ space: 15 }) {
                Column() {
                  Image($r('app.media.temperature'))
                    .width(40)
                    .height(40)
                    .objectFit(ImageFit.Contain)
                }
                .borderRadius(999)
                .backgroundColor('#eac694')


                Text((this.airArr.length != 0 && !this.airArr[0].isEmpty() ? this.airArr[0].air_temp.toString() : '26') + "℃")
                  .fontSize(30)
                  .fontColor(Color.White)
              }

              // 第二行：状态指示
              Text("温度偏低")
                .fontSize(30)
                .fontColor(Color.Red)
                .fontWeight(FontWeight.Bold)
            }
            .width(180)
            .height(180)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#0b722f')
            .borderRadius(999)
            .shadow({
              radius: 15,
              color: Color.Black,
              offsetX: 4,
              offsetY: 4,
            })
            .onClick(() => this.MessageDialogController.open())
            .position({ x: '35%', y: '10%' })
            .zIndex(3)

            Column() {
              Text('大棚室内湿度')
                .fontSize(32)
                .fontColor(Color.Blue)
                .fontWeight(FontWeight.Bolder)
            }
            .position({ x: '65%', y: '45%' })

            // 大棚空气湿度
            Column({space:15}) {
              Row({ space: 15 }) {
                Column() {
                  Image($r('app.media.humidity'))
                    .width(40)
                    .height(40)
                    .objectFit(ImageFit.Contain)
                }
                .borderRadius(999)
                .backgroundColor('#6ebaea')

                Text((this.airArr.length != 0 && !this.airArr[0].isEmpty() ? this.airArr[0].air_humid.toString() : '85') + "%")
                  .fontSize(30)
                  .fontColor(Color.White)
              }

              Text(this.airArr.length != 0 && !this.airArr[0].isEmpty() ? this.airArr[0].air_humid < 40 ? "湿度正常偏低" : "湿度正常" : "湿度正常")
                .fontSize(30)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
            }
            .width(180)
            .height(180)
            .justifyContent(FlexAlign.Center)
            .backgroundColor("#ff168c36")
            .borderRadius(999)
            .shadow({
              radius: 15,
              color: Color.Black,
              offsetX: 4,
              offsetY: 4,
            })
            .onClick(() => this.MessageDialogController.open())
            .position({ x: '65%', y: '55%' })
            .zIndex(3)

            Column() {
              Image($r('app.media.crop'))
                .width(90)
                .onClick(async ()=>{
                  console.log("ok")
                  let arr = await Air.getNewData()
                  // console.log('Air data is ', arr[0].toString())
                  console.log("good")
                })
            }
            .width(120)
            .height(120)
            .justifyContent(FlexAlign.Center)
            .borderWidth(3)
            .backgroundColor('#ffc1eec1')
            .borderRadius(75)
            .position({ x: '38%', y: '65%' })
            .zIndex(1)
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.tabBuilder(0,'空气模块'))

        TabContent() {
          Column({space: 10}) {
            Row({space: 30}) {
              Column({ space: 10 }) {
                Row() {
                  Text("当前土壤：")
                    .fontSize(22)
                    .alignSelf(ItemAlign.Start)
                    .fontColor(Color.White)
                    .padding({left: 10})

                  Text("3号水稻地")
                    .fontSize(22)
                    .alignSelf(ItemAlign.Start)
                    .fontColor(Color.White)
                    .padding({left: 10})
                }

                Grid() {
                  GridItem() {
                    Column() {
                      Row({space:10}) {
                        Text("当前土壤温度：")
                          .fontSize(22)
                          .fontColor(Color.White)

                        Text((this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].temperature_value.toString() : '22') + "℃")
                          .fontSize(22)
                          .fontColor(Color.White)

                      }
                      .width('90%')
                      .height('60%')
                      .borderRadius(20)
                      .justifyContent(FlexAlign.Center)

                      Column() {
                        Text("偏低")
                          .fontSize(22)
                          .fontWeight(800)
                          .fontColor(Color.Red)
                      }
                    }
                  }

                  GridItem() {
                    Column() {
                      Row({space:10}) {
                        Text("当前土壤湿度：")
                          .fontSize(22)
                          .fontColor(Color.White)

                        Text((this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].moisture_value.toString() : '80') + "%")
                          .fontSize(22)
                          .fontColor(Color.White)
                      }
                      .width('90%')
                      .height('60%')
                      .borderRadius(20)
                      .justifyContent(FlexAlign.Center)

                      Column() {
                        Text("正常")
                          .fontSize(22)
                          .fontWeight(800)
                          .fontColor('#ff00f7ff')
                      }
                    }
                  }

                }
                .width('90%')
                .height('70%')
                .rowsTemplate('1fr 1fr')
              }
              .width(320)
              .height(200)
              .borderRadius(10)
              .justifyContent(FlexAlign.SpaceEvenly)
              .backgroundColor("#ff0b722f")
              .opacity(0.8)
              .onClick(()=>{
                this.MessageDialogController.open()
              })

              Column({ space: 10 }) {
                Row() {
                  Text("土壤导电率:")
                    .fontSize(22)
                    .padding({left: 10})
                    .fontColor(Color.White)

                  Text("36%")
                    .fontSize(22)
                    .padding({left: 10})
                    .fontColor(Color.White)
                }

                Image($r('app.media.O2CO2'))
                  .width(300)
                  .height(150)
                  .objectFit(ImageFit.Fill)

              }
              .width(320)
              .height(200)
              .borderRadius(10)
              .justifyContent(FlexAlign.SpaceEvenly)
              .backgroundColor("#ff0b722f")
              .opacity(0.8)
              .onClick(()=>{
                this.MessageDialogController.open()
              })
            }
            .margin({top:5})


            Row({space: 30}) {
              Column({ space: 10 }) {
                Row() {
                  Text("大棚空气湿度")
                    .fontSize(30)
                    .alignSelf(ItemAlign.Start)
                    .fontColor(Color.White)
                    .padding({left: 10})

                }

                Row({space:10}) {
                  Text("当前土壤PH:")
                    .fontSize(25)
                    .fontColor(Color.White)

                  Text((this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].pH_value.toString() : '8.1') )
                    .fontSize(25)
                    .fontColor(Color.White)
                }

                Text("偏高")
                  .fontSize(25)
                  .fontWeight(800)
                  .fontColor(Color.Red)
              }
              .width(320)
              .height(200)
              .borderRadius(10)
              .justifyContent(FlexAlign.SpaceEvenly)
              .backgroundColor("#0b6f6c")
              .onClick(()=>{
                this.MessageDialogController.open()
              })

              Column({ space: 10 }) {
                Column({ space: 10 }) {

                  Text("土壤营养元素含量")
                    .fontSize(22)
                    .fontColor(Color.White)
                    .padding({ left: 10 })

                  Row({space:10}) {
                    this.myText("氮（N）: "+ (this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].nitrogen.toString() : '36') +"%")
                    Text("正常")
                      .fontSize(22)
                      .fontWeight(800)
                      .fontColor('#ff00f7ff')
                  }

                  Row({space:10}) {
                    this.myText("磷（P）: " + (this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].phosphorus.toString() : '25') + "%")
                    Text("偏低")
                      .fontSize(22)
                      .fontWeight(800)
                      .fontColor(Color.Red)
                  }

                  Row({space:10}) {
                    this.myText("钾（K）: "+ (this.soilArr.length != 0 && !this.soilArr[0].isEmpty() ? this.soilArr[0].potassium.toString() : '24') + "%")
                    Text("正常")
                      .fontSize(22)
                      .fontWeight(800)
                      .fontColor('#ff00f7ff')
                  }


                }
                .width(320)
                .height(200)
                .borderRadius(10)
                .justifyContent(FlexAlign.SpaceEvenly)
                .backgroundColor("#0b6f6c")
                .onClick(()=>{
                  this.MessageDialogController.open()
                })
              }
            }

            Column() {
              Image($r('app.media.crop'))
                .width(65)
                .onClick(()=> {

                })
            }
            .width(80)
            .height(80)
            .borderWidth(3)
            .backgroundColor('#ffc1eec1')
            .borderRadius(70)
            .position({x:320,y:170})
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.tabBuilder(1,'土地模块'))

      }
      .onChange((index: number) => {
        this.curIndex = index
      })

    }
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#ff6cae7a')
    .width('100%')
    .height('100%')

  }

  @Builder
  myText(text: string){
    Row() {
      Text(text)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
    }
    .width(200)
    .height(30)
    .backgroundColor('#ffffffff')
    .justifyContent(FlexAlign.Center)
    .borderRadius(15)
    .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
  }
}


@CustomDialog
export default struct MessageDialog {
  controller: CustomDialogController
  build(){
    Column({space:5}){
      Text(`湿度变化表`)
        .fontSize(25)
        .height(35)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .padding({ top: 10 })

      Column() {
        Image(ImageFetcher.fetchImage('humid_detector2_pie.png'))
          .width(400)
          .onClick(()=>{
            console.log("good")
          })
          // .width(780)
          // .height(450)
          // .objectFit(ImageFit.Fill)
      }
      .padding(5)

      // 确定按钮
      Row({ space: 5 }) {
        Button('确定')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .backgroundColor('#007DFF')
          .borderRadius(25)
          .height(40)
          .width(200)
          .onClick(() => {
            this.controller.close();
          })
      }
    }
    .width(800)
    .height(550)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#2E2E2E')
    .borderRadius(20)
    .shadow({ radius: 15, color: '#000000', offsetX: 0, offsetY: 4 })
  }
}
