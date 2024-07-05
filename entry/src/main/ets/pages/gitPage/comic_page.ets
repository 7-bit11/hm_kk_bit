import router from '@ohos.router';
import ComicEntity, { ComicImage } from '../../entitys/comic_entity';
import comicModel from '../../model/comic_model';
import infoModel from '../../model/Info_model';

@Entry
@Component
struct ComicPage {
  private value: object = router.getParams();
  @State info: ComicEntity = new ComicEntity();

  // 初始化数据查询info
  aboutToAppear() {
    console.error("aboutToAppear============");
    comicModel.getComicEntity(this.value['id']).then(data => {
      this.info = data;
    });
  }

  build() {
    Navigation() {
      List() {

        ForEach(this.info.data?.comic_info?.comic_images, (comic: ComicImage) => {
          ListItem() {
            Image(comic.url)
              .sourceSize({ width: comic.width, height: comic.height })
              .alt($rawfile('loading.gif'))
              .objectFit(ImageFit.Fill)
          }
        })

      }
    }.title(this.value['name']).titleMode(NavigationTitleMode.Mini)

  }
}