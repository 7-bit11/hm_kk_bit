import http from '@ohos.net.http';
import HotListEntity from '../entitys/hot_list_entity';
import InfoEntity from '../entitys/info_entity';


class InfoModel {
  url: string = "https://www.kuaikanmanhua.com/v2/pweb/topic/";

  getInfoEntity(id: String): Promise<InfoEntity> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(this.url + id, { method: http.RequestMethod.GET }).then(rp => {
        console.error("=getInfoEntity=" + rp.responseCode);
        if (rp.responseCode == 200) {
          console.error("=getInfoEntity=获取成功");
          console.error(rp.result.toString())
          resolve(JSON.parse(rp.result.toString()));
        } else {
          console.error("=getInfoEntity=失败");
          reject("查询失败了");
        }
      }).catch(e => {
        console.error("=getInfoEntity=error", e.toString());
        reject("查询失败了" + e);
      }).finally(() => {
        console.error("=getInfoEntity=", "=finally=");
        reject("请稍后重试");
      });

    });

  }
}

const infoModel = new InfoModel();

export default infoModel as InfoModel;