import router from '@ohos.router';
import HotListEntity, { Topic } from '../entitys/hot_list_entity';
import hotList from "../model/HotListModel"
import { borderRadiuses } from '@ohos.arkui.node';

@Entry
@Component
struct Index {
  @State bgColors: String[] =
    ["https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/1fb41113931998c9d72f614a0c3dcffd/Konachan.com%20-%20378456%20sample.jpg",
      "https://konachan.net/sample/d5cb9f11e3ed6af23a4286c5bd5233b4/Konachan.com%20-%20378252%20sample.jpg",
      "https://konachan.net/sample/53a8a892a4c36f3c9d96be289e02f65c/Konachan.com%20-%20378099%20sample.jpg",
      "https://konachan.net/sample/b62dd7f9bfecd2712d4818f800d01dc1/Konachan.com%20-%20378149%20sample.jpg",
      "https://konachan.net/sample/9bc194416b7a303b570acb4fc7cb38ef/Konachan.com%20-%20378151%20sample.jpg",
      "https://konachan.net/sample/6a2b1a51e129e3d1fd72937dd6e2e1e1/Konachan.com%20-%20378152%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/1fb41113931998c9d72f614a0c3dcffd/Konachan.com%20-%20378456%20sample.jpg",
      "https://konachan.net/sample/d5cb9f11e3ed6af23a4286c5bd5233b4/Konachan.com%20-%20378252%20sample.jpg",
      "https://konachan.net/sample/53a8a892a4c36f3c9d96be289e02f65c/Konachan.com%20-%20378099%20sample.jpg",
      "https://konachan.net/sample/b62dd7f9bfecd2712d4818f800d01dc1/Konachan.com%20-%20378149%20sample.jpg",
      "https://konachan.net/sample/9bc194416b7a303b570acb4fc7cb38ef/Konachan.com%20-%20378151%20sample.jpg",
      "https://konachan.net/sample/6a2b1a51e129e3d1fd72937dd6e2e1e1/Konachan.com%20-%20378152%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/1fb41113931998c9d72f614a0c3dcffd/Konachan.com%20-%20378456%20sample.jpg",
      "https://konachan.net/sample/d5cb9f11e3ed6af23a4286c5bd5233b4/Konachan.com%20-%20378252%20sample.jpg",
      "https://konachan.net/sample/53a8a892a4c36f3c9d96be289e02f65c/Konachan.com%20-%20378099%20sample.jpg",
      "https://konachan.net/sample/b62dd7f9bfecd2712d4818f800d01dc1/Konachan.com%20-%20378149%20sample.jpg",
      "https://konachan.net/sample/9bc194416b7a303b570acb4fc7cb38ef/Konachan.com%20-%20378151%20sample.jpg",
      "https://konachan.net/sample/6a2b1a51e129e3d1fd72937dd6e2e1e1/Konachan.com%20-%20378152%20sample.jpg"]
  scroller: Scroller = new Scroller()
  @State hotListData: HotListEntity = new HotListEntity();

  aboutToAppear() {
    console.error("aboutToAppear============");
    setTimeout(() => {
      hotList.getHotListEntity().then(data => {
        this.hotListData = data;
      });
    }, 1000);

  }

  build() {
    Navigation() {
      //Column({ space: 10 }) {
      // Row() {
      //   Text("7_bit")
      //   Button({ type: ButtonType.Circle }).width(24).height(24).onClick(() => {
      //     router.pushUrl({ url: 'pages/gitPage/list_loading' }, router.RouterMode.Single,
      //       error => {
      //         if (error) {
      //           console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
      //         }
      //       });
      //   })
      // }.width("100%").jus tifyContent(FlexAlign.SpaceBetween)

      Grid(this.scroller) {
        ForEach(this.hotListData.data?.topics, (topic: Topic) => {
          GridItem() {
            Column() {
              Image(topic.vertical_image_url)
                .height(250)//.borderRadius(borderRadiuses(10))
                .alt($rawfile('loading.gif'))
                .width("100%")
                .objectFit(ImageFit.Fill)
                .border({
                  radius: {
                    topLeft: 6,
                    topRight: 6
                  }
                })
              Text(topic.title).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).padding(5)
              Text(topic.tags?.join("|")).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).padding(5)
            }
            .borderRadius(6)
            .backgroundColor($r("app.color.245"))
          }.onClick(() => {
            router.pushUrl({ url: 'pages/gitPage/git_page', params: { 'data': topic.cover_image_url } },
              router.RouterMode.Single,
              error => {
                if (error) {
                  console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
                }
              });
          })
        })
      }
      .width("100%")
      .height("100%") // 滚动方向纵向
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(1) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .columnsTemplate('1fr 1fr') //设置行数 以及比例
      .borderRadius(10)
      .columnsGap(5) //间距
      .rowsGap(5) //间距
      .padding(10)

      // }.padding(10).layoutWeight(1)

    }.title('LoadingMoreListDemo').titleMode(NavigationTitleMode.Free)

    //.menus(this.NavigationMenus())
  }

  @Builder
  NavigationMenus() {
    Image('resources/base/media/startIcon.png')
      .width(24)
      .height(24).onClick(() => {
      router.pushUrl({ url: 'pages/gitPage/list_loading' }, router.RouterMode.Single,
        error => {
          if (error) {
            console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
          }
        });
    }).margin(10)
  }
}