#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct date {
    char day[8];
    int month;
    int year;
} Date;

void printCalendar(Date *pa_calendar, const int pa_size)
{
    Date *cal = pa_calendar;
    int i;
    for(i = 0; i < pa_size; i++, cal++)
    {
        printf("%s\t%d\t%d\t%p\n", cal->day, cal->month, cal->year, cal);
    }
}

int main(int argc, char **argv)
{
    int size = 3;
//    Date calendar[size];
    Date *calendar = calloc(size, sizeof(Date));

    Date *calendar_addr = calendar;
    int i;
    for(i = 0; i < size; i++, calendar_addr++)
    {
        strncpy(calendar_addr->day, "Mon", 4);
        calendar_addr->month = i + 3;
        calendar_addr->year = 2016 - i;
    }

//    printCalendar(&calendar, 3);
    printCalendar(calendar, size);

    printf("\n\n");
    printf("%lu\n", sizeof(Date) * size);
    printf("%lu\n", sizeof(*calendar));
    printf("\n\n");

    FILE *f = fopen("output", "wb");
    if(f != NULL)
    {
        fwrite(calendar, sizeof(Date) * size, 1, f);
        fclose(f);
    }

    memset(calendar, '\0', sizeof(Date) * size);

//    printCalendar(calendar, 3);

    Date *calendar2 = calloc(size, sizeof(Date));
    f = fopen("output", "rb");
    if(f != NULL)
    {
        fread(calendar2, sizeof(Date) * size, 1, f);
        fclose(f);
    }

    printCalendar(calendar2, size);

    free(calendar);
    calendar = NULL;

    free(calendar2);
    calendar = NULL;

    return 0;
}
