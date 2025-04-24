// common/breakpointsystem.ets
import mediaQuery from '@ohos.mediaquery'


// 泛型接口 根据不同的 断点值，返回对应的结果
declare interface BreakPointTypeOption<T> {
  xs?: T
  sm?: T
  md?: T
  lg?: T
  xl?: T
  xxl?: T
}

export class BreakPointType<T> {
  options: BreakPointTypeOption<T>

  // 实例化时传入对应的配置信息
  constructor(option: BreakPointTypeOption<T>) {
    this.options = option
  }

  // 根据断点值，返回对应的设置
  getValue(currentBreakPoint: string) {
    if (currentBreakPoint === 'xs') {
      return this.options.xs
    } else if (currentBreakPoint === 'sm') {
      return this.options.sm
    } else if (currentBreakPoint === 'md') {
      return this.options.md
    } else if (currentBreakPoint === 'lg') {
      return this.options.lg
    } else if (currentBreakPoint === 'xl') {
      return this.options.xl
    } else if (currentBreakPoint === 'xxl') {
      return this.options.xxl
    } else {
      return undefined
    }
  }
}

interface Breakpoint {
  name: string
  size: number
  mediaQueryListener?: mediaQuery.MediaQueryListener
}

// AppStorage中保存断点的 key
export const BreakpointKey = 'Breakpoint'

export class BreakpointSystem {
  private currentBreakpoint: string = 'lg'
  // 定义断点值
  // private breakpoints: Breakpoint[] = [
  //   { name: 'xs', size: 0 }, { name: 'sm', size: 320 },
  //   { name: 'md', size: 600 }, { name: 'lg', size: 840 }
  // ]

  // 依据RK3588重新设计的尺寸
  private breakpoints: Breakpoint[] = [
     { name: 'sm', size: 250 },
     { name: 'lg', size: 670 }
  ]
  // 更新 AppStorage 中保存的断点信息
  private updateCurrentBreakpoint(breakpoint: string) {
    if (this.currentBreakpoint !== breakpoint) {
      this.currentBreakpoint = breakpoint
      AppStorage.setOrCreate<string>(BreakpointKey, this.currentBreakpoint)
      console.log('on current breakpoint: ' + this.currentBreakpoint)
    }
  }

  // 注册媒体查询的事件
  public register() {
    this.breakpoints.forEach((breakpoint: Breakpoint, index) => {
      let condition: string
      if (index === this.breakpoints.length - 1) {
        condition = '(' + breakpoint.size + 'vp<=width' + ')'
      } else {
        condition = '(' + breakpoint.size + 'vp<=width<' + this.breakpoints[index + 1].size + 'vp)'
      }
      // 等同于注册了4 个范围区间
      //  xs:(0vp<=width<320vp) 智能穿戴，比如手表
      //  sm:(320vp<=width<600vp) 手机
      //  md:(600vp<=width<840vp) 折叠屏
      //  lg:(840vp<=width) 平板
      //  当在某个范围内就会将 断点值保存到 AppStorage 中
      breakpoint.mediaQueryListener = mediaQuery.matchMediaSync(condition)
      breakpoint.mediaQueryListener.on('change', (mediaQueryResult) => {
        if (mediaQueryResult.matches) {
          this.updateCurrentBreakpoint(breakpoint.name)
        }
      })
    })
  }

  // 移除注册的事件
  public unregister() {
    this.breakpoints.forEach((breakpoint: Breakpoint) => {
      if (breakpoint.mediaQueryListener) {
        breakpoint.mediaQueryListener.off('change')
      }
    })
  }
}