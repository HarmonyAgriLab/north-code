import http from '@ohos.net.http';
import buffer from '@ohos.buffer';

export class ImageFetcher {
  private static baseUrl: string = 'http://189.1.245.236:8000/images/';

  static fetchImage(imageName: string): string {
    return this.baseUrl+imageName
  }
}