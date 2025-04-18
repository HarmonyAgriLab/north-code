import cloud, { AuthUser, VerifyCodeAction } from '@hw-agconnect/cloud'
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';

interface LogInResult{
  loginEnable: boolean
  user?: AuthUser
}

class AGCCloud {

  async requestVerifyCode(phoneNumber: string) { // 申请手机验证码
    try {
      await cloud.auth().requestVerifyCode({
        verifyCodeType: {
          kind: 'phone',
          phoneNumber: phoneNumber,
          countryCode: '86'
        },
        action: VerifyCodeAction.REGISTER_LOGIN,
        lang: 'zh_CN',
        sendInterval: 30
      })

      promptAction.showToast({
        message: '成功获取验证码',
        duration: 2000
      })

      hilog.info(0, 'VerifyCode', 'Success')
      return true;
    } catch (err) {
      // 发送验证码失败弹窗
      promptAction.showToast({
        message: '获取验证码失败',
        duration: 2000
      })
      hilog.info(0, 'VerifyCode', JSON.stringify(err))
      return false
    }
  } // 申请手机验证码

  async createUser(phoneNumber: string, verifyCode: string) { // 以手机验证码创建用户/登录
    try {
      await cloud.auth().signOut() // 退出缓存登录用户
      const result = await cloud.auth().signIn({
        credentialInfo: {
          kind: 'phone',
          countryCode: '86',
          phoneNumber: phoneNumber,
          verifyCode: verifyCode
        }
      })
      promptAction.showToast({
        message: '登录成功',
        duration: 2000
      })
      // 若验证码正确则保存对于账户到本地
      const user: AuthUser = result.getUser()
      hilog.info(0, 'LogIn', 'Success')
      const loginResult: LogInResult = {
        loginEnable: true,
        user: user
      }
      return loginResult
    } catch (err) {
      // 登录失败弹窗
      promptAction.showToast({
        message: '登录失败',
        duration: 2000
      })
      hilog.info(0, 'LogIn', JSON.stringify(err))
      const loginResult: LogInResult = {
        loginEnable: false
      }
      return loginResult
    }
  } // 以手机验证码创建/登录用户
}

const agcCloud = new AGCCloud()

export default agcCloud as AGCCloud