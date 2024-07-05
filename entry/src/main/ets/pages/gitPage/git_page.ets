import router from '@ohos.router';
import InfoEntity, { Comic } from '../../entitys/info_entity';
import infoModel from '../../model/Info_model';

@Entry
@Component
struct GifPage {
  private value: object = router.getParams();
  @State info: InfoEntity = new InfoEntity();

  // 初始化数据查询info
  aboutToAppear() {
    console.error("aboutToAppear============");
    infoModel.getInfoEntity(this.value['id']).then(data => {
      this.info = data;
    });
  }

  build() {
    Navigation() {
      List({ space: 10 }) {

        ListItem() {
          this._getAppbar()
        }

        ListItem() {
          Text(this.info.data?.topic_info?.title).fontSize(18).fontWeight(FontWeight.Bold)
        }

        ListItem() {
          Text(this.info.data?.topic_info?.description)
            .fontColor(Color.Grey)
        }

        ListItem() {
          Grid() {
            ForEach(this.info.data?.topic_info?.comics, (comic: Comic) => {
              GridItem() {
                this._itemWidget(comic.cover_image_url, comic.title, comic.id);
              }
            })
          }.columnsTemplate('1fr 1fr') //设置行数 以及比例
          .borderRadius(10)
          .columnsGap(5) //间距
          .rowsGap(5) //间距
        }
      }.padding(10)
    }.title(this.value['name']).titleMode(NavigationTitleMode.Mini)

  }

  @Builder
  _getAppbar() {
    Image(this.info.data?.topic_info?.cover_image_url)
      .width("100%")
      .objectFit(ImageFit.Auto)
      .borderRadius(8)
      .alt($rawfile('loading.gif'))
      .height(200)
  }

  @Builder
  _itemWidget(url: string | undefined, text: string | undefined, id: number | undefined) {
    Column({ space: 5 }) {
      Image(url)
        .height(100)
        .width("100%")
        .borderRadius(10)
        .objectFit(ImageFit.Auto)
        .alt($rawfile('loading.gif'))
      Text(text).textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1)
    }.onClick(() => {
      router.pushUrl({ url: 'pages/gitPage/comic_page' ,params:{'id':id}}, router.RouterMode.Single,
        error => {
          if (error) {
            console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
          }
        })
    })
  }
}