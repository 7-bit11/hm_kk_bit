import {
  LoadingMoreBase,
} from '@candies/loading_more_list'

export class ListData extends LoadingMoreBase<number> {
  hasMore: boolean = true;
  pageSize: number = 10;
  maxCount: number = 20;

  public async refresh(notifyStateChanged: boolean = false): Promise<boolean> {
    this.hasMore = true;
    return super.refresh(notifyStateChanged);
  }

  async loadData(isLoadMoreAction: boolean): Promise<boolean> {
    // 模拟请求延迟 1 秒
    return new Promise<boolean>((resolve) => {
      setTimeout(() => {
        let length = this.length;
        let list:Array<number> = [];

        for (let index = length; index < length + this.pageSize; index++)          {
          list.push(index);
        }
        this.addAll(list);

        if (this.length >= this.maxCount) {
          this.hasMore = false;
        }
        resolve(true);
      }, 1000);
    });
  }
}
