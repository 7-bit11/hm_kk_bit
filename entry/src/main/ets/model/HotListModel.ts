import http from '@ohos.net.http';
import HotListEntity from '../entitys/hot_list_entity';

class HotListModel {
  url: string = "https://www.kuaikanmanhua.com/v2/pweb/daily/topics";

  getHotListEntity(): Promise<HotListEntity> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(this.url, { method: http.RequestMethod.GET }).then(rp => {
        if (rp.responseCode == 200) {
          console.error("=getHotListEntity=获取成功");
          console.error(rp.result.toString())
          resolve(JSON.parse(rp.result.toString()));
        } else {
          console.error("=getHotListEntity=失败");
          reject("查询失败了");
        }
      }).catch(e => {
        console.error("=getHotListEntity=error", e.toString());
        reject("查询失败了" + e);
      }).finally(() => {
        console.log("=getHotListEntity=", "=finally=");
        reject("请稍后重试");
      });
    });

  }
}

const hotList = new HotListModel();

export default hotList as HotListModel;