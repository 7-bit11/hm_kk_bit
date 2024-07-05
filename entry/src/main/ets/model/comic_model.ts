import http from '@ohos.net.http';
import ComicEntity from '../entitys/comic_entity';


class ComicModel {
  url: string = "https://m.kuaikanmanhua.com/v2/mweb/comic/";

  getComicEntity(id: number): Promise<ComicEntity> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(this.url + id, { method: http.RequestMethod.GET }).then(rp => {
        console.error("=getComicEntity=" + rp.responseCode);
        if (rp.responseCode == 200) {
          console.error("=getComicEntity=获取成功");
          console.error(rp.result.toString())
          resolve(JSON.parse(rp.result.toString()));
        } else {
          console.error("=getComicEntity=失败");
          reject("查询失败了");
        }
      }).catch(e => {
        console.error("=getComicEntity=error", e.toString());
        reject("查询失败了" + e);
      }).finally(() => {
        console.error("=getComicEntity=", "=finally=");
        reject("请稍后重试");
      });

    });

  }
}

const comicModel = new ComicModel();

export default comicModel as ComicModel;