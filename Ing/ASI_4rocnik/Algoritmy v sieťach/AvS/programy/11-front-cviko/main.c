#include<stdio.h>
#include<malloc.h>
#include<stdlib.h>
struct node
{
    struct node *next;
    int data;
};

struct queue
{
    struct node *front;
    struct node *rear;
};

struct queue *q;

void createq(struct queue *);
struct queue *insert(struct queue *);
struct queue *delete_q(struct queue *);
struct queue *display(struct queue *);

void createq(struct queue *q)
{
    q->rear=NULL;
    q->front=NULL;
    printf("q intialized");
}

struct queue *insert(struct queue *q)
{
    struct node *newnode;
    int val;
    newnode=(struct node *)malloc(sizeof(struct node));
    printf("Enter the value to be inserted:");
    scanf("%d",&val);
    newnode->data=val;
    if(q->front==NULL)
    {
        q->front=newnode;
        q->rear=newnode;
        q->front->next=q->rear->next=NULL;
    }
    else
    {
        q->rear->next=newnode;
        q->rear=newnode;
        q->rear->next=NULL;
    }
    return q;
}

struct queue *delete_q(struct queue *q)
{
    struct node *ptr;
    if(q->front==NULL)
    {
        printf("Queue Empty\n");
    }
    else
    {
        ptr=q->front;
        q->front=q->front->next;
        printf("Element being deleted is %d\n",ptr->data);
        free(ptr);
    }
    return q;
}

struct queue *display(struct queue *q)
{
    struct node *ptr;
    ptr=q->front;
    if(q->front==NULL)
    printf("Queue Empty!!\n");
    else
    {
        while(ptr!=q->rear)
        {
            printf("%d\t",ptr->data);
            ptr=ptr->next;
        }
        printf("%d\t",ptr->data);
            printf("\n");
    }
    return q;
}

int main()
{
    q = (struct queue *)malloc(sizeof(struct queue));
    int option;
    printf("\tMAIN MENU\n");
    printf("\n1. Create\n2. Display\n3. Insert\n4. Delete\n5. Exit\n");
    while(option!=5)
    {
        printf("\nEnter a choice:");
        scanf("%d",&option);
        switch(option)
        {
        case 1:
            createq(q);
            break;

        case 2:
            q=display(q);
            break;

        case 3:
            q=insert(q);
            break;

        case 4:
            q=delete_q(q);
            break;
        }
    }
    free(q);
    return 0;
}