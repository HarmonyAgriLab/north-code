import http from '@ohos.net.http';
import buffer from '@ohos.buffer';

export class ImageFetcher {
  private static baseUrl: string = 'http://189.1.245.236:8000/images/';

  static async fetchImage(imageName: string): Promise<string | null> {
    const url = ImageFetcher.baseUrl+imageName;

    return new Promise((resolve, reject) => {
      const request = http.createHttp();
      request.request(
        url,
        {
          method: http.RequestMethod.GET,
          header: { 'Content-Type': 'application/json' },
        },
        (err, data) => {
          if (err) {
            console.error('ImageFetcher 获取图像失败:', err);
            reject(new Error('ImageFetcher 获取图像失败'));
          } else {
            const result = data.result as string;
            const base64Image = buffer.from(result).toString('base64'); // 转换为 base64 ? or 其他格式
            resolve(base64Image);
          }
        }
      );
    });
  }
}