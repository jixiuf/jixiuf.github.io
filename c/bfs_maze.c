//file name : bfs_maze_queue.c
//created at: 2012年04月25日 星期三 00时38分25秒
//author:  纪秀峰
/* 队列与广度优先 */
/* 变量head和tail是队头和队尾指针，head总是指向队头，tail总是指向队尾的下一个元
   素。每个点的predecessor成员也是一个指针，指向它的前趋在queue数组中的位置。如
   下图所示： */
/* 从打印的搜索过程可以看出，这个算法的特点是沿各个方向同时展开搜索，每个可以走
   通的方向轮流往前走一步，这称为广度优先搜索（BFS，Breadth First Search）。探
   索迷宫和队列变化的过程如下图所示。 */

/* 广度优先是一种步步为营的策略，每次都从各个方向探索一步，将前线推进一步，图中
   的虚线就表示这个前线，队列中的元素总是由前线的点组成的，可见正是队列先进先出
   的性质使这个算法具有了广度优先的特点。广度优先搜索还有一个特点是可以找到从起
   点到终点的最短路径，而深度优先搜索找到的不一定是最短路径，比较本节和上一节程
   序的运行结果可以看出这一点，想一想为什么。 */

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>

#define MAX_ROW 5
#define MAX_COL 5

struct point {int x,y,predecessor;} queue[512];
int head=0,tail=0;
void enqueue(struct point p){
  queue[tail++]=p;
}
struct point  dequeue(){
  return queue[head++];
}
isempty(){
  return head==tail;
}
int maze[MAX_ROW][MAX_COL] = {
  0, 1, 0, 0, 0,
  0, 1, 0, 1, 0,
  0, 0, 0, 0, 0,
  0, 1, 1, 1, 0,
  0, 0, 0, 1, 0,
};


void print_maze(){
  int i,j;
  for ( i = 0; i < MAX_ROW; ++i) {
    for ( j = 0; j< MAX_COL; ++j) {
      printf ("%d, ",maze[i][j]);
    }
    printf ("\n");
  }
  printf ("\n");
}
visit(int x, int y){
  struct point cur={x,y,head-1};
  maze[x][y]=2;
  enqueue(cur);

}

int main(int argc, char *argv[]){
  struct point p ={0,0};
  maze[0][0]=2;
  enqueue(p);
  while(!isempty()){
     p =dequeue();
    if(p.x==MAX_ROW-1&&p.y==MAX_COL-1){
      break;
    }
    if (p.y<MAX_COL-1&&maze[p.x][p.y+1]==0){
      visit(p.x,p.y+1);
    }
    if(p.x<MAX_ROW-1 &&maze[p.x+1][p.y]==0){
      visit(p.x+1,p.y);
    }
    if(p.y>0&&maze[p.x][p.y-1]==0){
      visit(p.x,p.y-1);
    }
    if(p.x>0&&maze[p.x-1][p.y]==0){
      visit(p.x-1,p.y);
    }
    print_maze();
  }
  while(!(p.x==0&&p.y==0)){
    printf ("%d,%d \n",p.x,p.y);
    p=queue[p.predecessor];
  }

  return 0;
}
