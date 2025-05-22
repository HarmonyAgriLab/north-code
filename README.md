
# 🌾 Agriculture 农业信息采集应用（OpenHarmony）

本项目是基于 **OpenHarmony（开源鸿蒙系统）** 开发的一个农业信息采集应用，用于展示和采集农业相关的数据，如土壤信息、传感器数据、图像处理结果等，旨在辅助智慧农业系统的开发与部署。

---

## 🧩 项目结构说明

```
Agriculture/
├── AppScope/              # 应用作用域配置（如权限配置、模块声明）
├── entry/                 # 主业务模块（UI 页面、后台逻辑、资源文件）
├── hvigor/                # 构建系统目录
├── .hvigor/               # 构建缓存目录（可忽略）
├── .idea/                 # DevEco Studio 工程配置文件
├── hvigorfile.ts          # 构建脚本入口文件
├── oh-package.json5       # 应用包元信息（如包名、依赖等）
├── local.properties       # 本地构建环境配置
├── .gitignore             # Git 提交忽略规则
```

---

## ⚙️ 环境要求

- 操作系统：Windows / macOS / Linux
- 开发工具：DevEco Studio 4.0+
- OpenHarmony SDK：API Version 10
- Node.js：16+（用于构建工具 hvigor）
- HMS Core SDK：如有使用系统能力需引入
- 预览器参数配置： 3588 tablet  1600×960  DPI 320

---

## ▶️ 编译运行方式

1. **克隆项目**

```bash
git clone https://github.com/HarmonyAgriLab/north-code.git
cd agriculture
```

2. **打开 DevEco Studio**

使用 DevEco Studio 打开 `Agriculture` 目录，首次会自动同步依赖和构建配置，并且需要手动设置 Node.js 路径。

3. **连接设备或模拟器并运行**

点击运行按钮，部署至模拟器或真机（需开启调试）。

4. **启动http模块**

在模拟器或者真机上需要提前连接网络，模拟器建议连接热点，以便后续使用项目中的http模块。

5. **打开项目**

打开项目后会先进入登录界面，需要手机进行登录，输入手机号后手机会收到短信验证码，验证码正确即可进入主界面

6. **运行项目**

项目包括四个主模块，分别为主页，设备，环境，设置。里面的数据都需要http模块才能从后端获取到。而模拟器无法获取后端数据。

7. **烧录**

在 DevEco Studio 中打开项目后，使用 双头USB-A线 连接开发板与电脑，并在IDE中进行项目签名后打包到开发板中即可。 



---

## 🔍 核心功能模块简介

| 模块路径 | 功能简介 |
|----------|----------|
| `entry/src/main/ets` | 核心业务逻辑、UI 页面及后台数据处理代码 |
| `entry/src/main/resources` | 多语言资源文件、图片资源等 |
| `AppScope/` | 应用的权限申请、模块配置、设备能力声明等 |
| `hvigor/` | 自定义构建任务配置（如签名、打包优化） |
| `entry/src/main/ets/model` | 设备控制模块（顶棚、地暖、遮阳伞等控制逻辑） |
| `entry/src/main/ets/pages` | 数据可视化展示、图表数据展示、界面UI |


---
