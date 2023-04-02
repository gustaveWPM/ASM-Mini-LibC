#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void printArray(int arr[], int n)
{
   for (int i=0; i<n; i++)
      printf("%d ", arr[i]);
    printf("\n");
}


void test_memset_a(void)
{
    char str[50] = "GeeksForGeeks is for programming geeks.";
    printf("Before memset(): %s\n", str);
  
    // Fill 8 characters starting from str[13] with '.'
    memset(str + 13, '.', 8*sizeof(char));
  
    printf("After memset():  %s", str);
    printf("\n\n");
}  

void test_memset_b()
{
    int n = 10;
    int arr[n];
  
    // Fill whole array with 0.
    memset(arr, 0, n * sizeof(arr[0]));
    printf("Array after memset()\n");
    printArray(arr, n);
}

void test_memset_c()
{
    int n = 10;
    int arr[n];
  
    // Fill whole array with 100.
    memset(arr, 10, n*sizeof(arr[0]));
    printf("Array after memset()\n");
    printArray(arr, n);
}

void test_strchr()
{
    const char * source = "The C Language";
    char * destination;
    char * pointer;
    int length = strlen( source );
    
    /* We clone the inital string */
    destination = (char *) malloc( sizeof( char) * (length+1) );
    strcpy( destination, source );
        
    /* We replace all 'a' characters */
    while (pointer = strchr( destination, 'a' ) ) {
        *pointer = 'A';
    }
    
    /* Display result : The C LAnguAge */
    printf( "Result : %s\n", destination );
        
    /* Release dynamicly allocated memory */
    free( destination );
}

void test_strstr()
{
    char *str1 = "helloworldilikecheese\n";
    char *str2 = "world";
    char *str3 = NULL;

    if (strstr(str1, str2))
        str3 = strdup(strstr(str1, str2));
    if (str3) {
        printf("%s", str3);
        free(str3);
    }
    else
        printf("%p", str3);
}

void test_strstr_notfound()
{
    char *str1 = "helloworldilikecheese\n";
    char *str2 = "bitecul";
    char *str3 = NULL;

    if (strstr(str1, str2))
        str3 = strdup(strstr(str1, str2));
    if (str3) {
        printf("%s", str3);
        free(str3);
    }
    else
        printf("%p\n", str3);
}

void test_strrchr_a()
{
   int len;
   const char str[] = "http://www.tutorialspoint.com";
   const char ch = '.';
   char *ret;

   ret = strrchr(str, ch);

   printf("String after |%c| is - |%s|\n", ch, ret);
}

void test_strrchr_b()
{
    const char * originalFilename = "folder/image.jpg";

    // On prépare le nom du fichier de destination
    size_t size = strlen( originalFilename ) + 1;   // +1 pour le zéro terminal
    char * destinationFilename = (char *) malloc( size );
    strcpy( destinationFilename, originalFilename );

    // Et on y remplace l'extension du fichier par l'extension .png
    char * lastDotPos = strrchr( destinationFilename, '.' );
    strcpy( lastDotPos, ".png" );

    // On affiche les deux noms de fichiers
    puts( originalFilename );
    puts( destinationFilename );
}

void test_memcpy_a(void)
{
   const char src[50] = "http://www.tutorialspoint.com";
   char dest[50];
   strcpy(dest,"Heloooo!!");
   printf("Before memcpy dest = %s\n", dest);
   memcpy(dest, src, strlen(src)+1);
   printf("After memcpy dest = %s\n", dest);
}

void test_memcpy_b()
{
    int array [] = { 54, 85, 20, 63, 21 };
    int * copy = NULL;
    int length = sizeof( int ) * 5;
       
    /* Memory allocation and copy */
    copy = (int *) malloc( length );
    memcpy( copy, array, length );
        
    /* Display the copied values */
    for( length=0; length<5; length++ ) {
        printf( "%d ", copy[ length ] );
    }
    printf( "\n" );
        
    free( copy );
}

void test_memcpy_c()
{
  char str1[] = "Geeks"; 
  char str2[] = "Quiz"; 
 
  puts("str1 before memcpy ");
  puts(str1);
 
  /* Copies contents of str2 to str1 */
  memcpy (str1, str2, sizeof(str2));
 
  puts("\nstr1 after memcpy ");
  puts(str1);
}

void test_memmove_a()
{
    char str[100] = "Learningisfun";
    char *first = str;
    char *second = str;
    printf("Original string :%s\n", str);

    // when overlap happens then it just ignore it
    memcpy(first + 8, first, 10);
    printf("memcpy overlap : %s\n", str);
  
    // when overlap it start from first position
    memmove(second + 8, first, 10);
    printf("memmove overlap : %s\n", str);
}

void test_memmove_b(void)
{
   char csrc[100] = "Geeksfor";

   memmove(csrc+5, csrc, strlen(csrc)+1);
   printf("%s\n", csrc);
}

void test_strpbrk()
{
    // Declaring three strings
    char s1[] = "geeksforgeeks";
    char s2[] = "app";
    char s3[] = "kite";
    char* r, *t;
  
    // Checks for matching character
    // no match found
    r = strpbrk(s1, s2); 
    if (r != 0)
        printf("First matching character: %c\n", *r);
    else
        printf("Character not found");
  
    // Checks for matching character
    // first match found at "e"
    t = strpbrk(s1, s3);
    if (t != 0) {
        printf("\nFirst matching character: %c\n", *t);
        printf("\n%%s: %s\n", t);
    } else
        printf("Character not found");
}

void test_strcspn_a()
{
    char *identifier = "spy007";

    // On cherche à savoir ou commence la partie numérique
    char *digits = "1234567890";
    size_t pos = strcspn(identifier, digits);

    // On récupère la partie clé
    char key[pos + 1];
    strncpy(key, identifier, pos);

    // On récupère le code numérique
    int code = atoi(identifier + pos);

    // On affiche les informations obtenues
    printf("Key: %s - Code: %d\n", key, code);
}

void test_strcspn_b()
{
    int size;
  
    // initializing strings
    char str1[] = "geeksforgeeks";
    char str2[] = "kfc";
  
    // using strcspn() to calculate initial chars
    // before 1st matching chars.
    // returns 3
    size = strcspn(str1, str2);
  
    printf("The unmatched characters before first matched character :  %d\n", size);
}

void test_memmove_c(void)
{
    char test[] = "abcdefghijklmnopqrstuvwxyz";
    memmove(test, test + 5, 10);
    printf("%s\n", test);
}

void test_memmove_d(void)
{
    char test[] = "abcdefghijklmnopqrstuvwxyz";
    memmove(test + 5, test, 10);
    printf("%s\n", test);
}

int main(void)
{
    test_memset_a();
    test_memset_b();
    test_memset_c();

    test_strchr();
    test_strrchr_a();
    test_strrchr_b();
    test_strstr();
    test_strstr_notfound();
    test_memcpy_a();
    test_memcpy_b();
    test_memcpy_c();
    test_memmove_a();
    test_memmove_b();
    test_memmove_c();
    test_memmove_d();
    test_strpbrk();
    test_strcspn_a();
    test_strcspn_b();

    return 0;
}
