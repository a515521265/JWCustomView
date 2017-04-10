//
//  helloC.c
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 2017/3/31.
//
//

#include "helloC.h"
#include <stdlib.h>
#include <string.h>

char *fun()
{
    char*s  = (char*)calloc(100,sizeof(char*));
    if (s)
        strcpy (s,"abc");
    return   s;
}
