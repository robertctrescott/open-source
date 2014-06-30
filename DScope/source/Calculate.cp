#line 1 "Z:/Robs Folder/DScope/source/Calculate.c"
#line 1 "z:/robs folder/dscope/include/calculate.h"
#line 7 "z:/robs folder/dscope/include/calculate.h"
typedef struct _T_i32str_res I32STR_RES;

struct _T_i32str_res {
 char decPos;
 char len;
 char str[13];
};

void Int32String_sign(I32STR_RES *r, int n, int e);
void Int32String(I32STR_RES *r, int n, int e);
void Char_to_Str(unsigned char *p, unsigned char n);
void Char_to_Hex(unsigned char *p, unsigned char n);
#line 10 "Z:/Robs Folder/DScope/source/Calculate.c"
void Int32String_sign(I32STR_RES *r, int n, int e)
{
 int i, m, c, fixlen;
 char *p = r->str;
 fixlen=e+2;
 if ( n == 0 ) {
 *p++ = ' ';
 *p++ = '0';
 *p++ = '.';
 *p++ = '0';
 *p++ = '0';
 *p = 0;
 r->decPos = 0;
 r->len = p-r->str;
 return;
 }
 if ( n > 0 )
 *p++ = ' ';
 else {
 *p++ = '-';
 n = -n;
 }
 m = n;
 i = 0;
 c = 5;
 while ( m >= 10 ) {
 m /= 10;
 if ( ++i > e ) c *= 10;
 }
 r->decPos = i/3;
 if ( i >= e ) n += c;
 switch ( i ) {
 case 9:
 *p++ = '0'+n/1000000000;
 if ( --e == 0 ) break;
 n %= 1000000000;
 *p++ = '.', i = 0;
 case 8:
 *p++ = '0'+n/100000000;
 if ( --e == 0 ) break;
 n %= 100000000;
 case 7:
 *p++ = '0'+n/10000000;
 if ( --e == 0 ) break;
 n %= 10000000;
 case 6:
 *p++ = '0'+n/1000000;
 if ( --e == 0 ) break;
 n %= 1000000;
 if ( i ) *p++ = '.', i = 0;
 case 5:
 *p++ = '0'+n/100000;
 if ( --e == 0 ) break;
 n %= 100000;
 case 4:
 *p++ = '0'+n/10000;
 if ( --e == 0 ) break;
 n %= 10000;
 case 3:
 *p++ = '0'+n/1000;
 if ( --e == 0 ) break;
 n %= 1000;
 if ( i ) *p++ = '.', i = 0;
 case 2:
 *p++ = '0'+n/100;
 if ( --e == 0 ) break;
 n %= 100;
 case 1:
 *p++ = '0'+n/10;
 if ( --e == 0 ) break;
 n %= 10;
 case 0:
 *p++ = '0'+n;
 }
 while ( p < r->str+fixlen )
 *p++ = ' ';
 *p = 0;
 r->len = p-r->str;
}
#line 92 "Z:/Robs Folder/DScope/source/Calculate.c"
void Int32String(I32STR_RES *r, int n, int e)
{
 int i, m, c, fixlen;
 char *p = r->str;
 fixlen=e+2;
 if ( n == 0 ) {
 *p++ = '0';
 *p++ = '.';
 *p++ = '0';
 *p++ = '0';
 *p++ = '0';
 *p = 0;
 r->decPos = 0;
 r->len = p-r->str;
 return;
 }






 m = n;
 i = 0;
 c = 5;
 while ( m >= 10 ) {
 m /= 10;
 if ( ++i > e ) c *= 10;
 }
 r->decPos = i/3;
 if ( i >= e ) n += c;
 switch ( i ) {
 case 9:
 *p++ = '0'+n/1000000000;
 if ( --e == 0 ) break;
 n %= 1000000000;
 *p++ = '.', i = 0;
 case 8:
 *p++ = '0'+n/100000000;
 if ( --e == 0 ) break;
 n %= 100000000;
 case 7:
 *p++ = '0'+n/10000000;
 if ( --e == 0 ) break;
 n %= 10000000;
 case 6:
 *p++ = '0'+n/1000000;
 if ( --e == 0 ) break;
 n %= 1000000;
 if ( i ) *p++ = '.', i = 0;
 case 5:
 *p++ = '0'+n/100000;
 if ( --e == 0 ) break;
 n %= 100000;
 case 4:
 *p++ = '0'+n/10000;
 if ( --e == 0 ) break;
 n %= 10000;
 case 3:
 *p++ = '0'+n/1000;
 if ( --e == 0 ) break;
 n %= 1000;
 if ( i ) *p++ = '.', i = 0;
 case 2:
 *p++ = '0'+n/100;
 if ( --e == 0 ) break;
 n %= 100;
 case 1:
 *p++ = '0'+n/10;
 if ( --e == 0 ) break;
 n %= 10;
 case 0:
 *p++ = '0'+n;
 }
 while ( p < r->str+fixlen )
 *p++ = ' ';
 *p = 0;
 r->len = p-r->str;
}
#line 174 "Z:/Robs Folder/DScope/source/Calculate.c"
void Char_to_Str(unsigned char *p, unsigned char n)
{
 *p++ = '0'+n/100;
 n %= 100;
 *p++ = '0'+n/10;
 n %= 10;
 *p++ = '0'+n;
 *p = 0;
}
#line 186 "Z:/Robs Folder/DScope/source/Calculate.c"
void Char_to_Hex(unsigned char *p, unsigned char n)
{
 if(n/16>9)
 *p++ = 'A'+(n/16-10);
 else
 *p++ = '0'+n/16;
 n %= 16;
 if(n>9)
 *p++ = 'A'+(n-10);
 else
 *p++ = '0'+n;
 *p++ = ' ';
 *p = 0;
}
