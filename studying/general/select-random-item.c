/*
 * select-random-item
 *
 * Select a random item from a given TXT list.
 *
 * Usage: select-random-item <file_path>
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// Use windows lib on Windows for better random number generator
#ifdef _WIN32
#include <windows.h>
#else
#include <time.h>
#endif

#define MAX_LINE_LENGTH 256

int main(int argc, char *argv[])

{
    if (argc != 2)
    {
        printf("select-random-item: select a random item from a given TXT list.\n");
        printf("Usage: %s <file_path>\n", argv[0]);
        return 1;
    }

    // Initialize the random number generator
    #ifdef _WIN32
    LARGE_INTEGER counter;
    QueryPerformanceCounter(&counter);
    srand((uint32_t) counter.QuadPart);
    #else
    srand(time(NULL));
    #endif

    // Open the file
    FILE *file = fopen(argv[1], "r");
    if (file == NULL)
    {
        printf("Error: could not open file: %s\n", argv[1]);
        return 1;
    }

    uint8_t **items = (uint8_t **) malloc(sizeof(uint8_t *));
    size_t items_count = 0;
    uint8_t line[MAX_LINE_LENGTH];

    while (fgets(line, sizeof(line), file) != NULL)
    {
        items = (uint8_t **) realloc(items, (++items_count) * sizeof(uint8_t *));
        items[items_count-1] = (uint8_t *) malloc(MAX_LINE_LENGTH);
        strcpy(items[items_count-1], line);
    }

    uint8_t random_index = rand() % items_count;
    printf("Selected item: %s\n", items[random_index]);

    // Free the memory and close the file
    for (size_t i = 0; i < items_count; i++)
    {
        free(items[i]);
    }
    free(items);
    fclose(file);

    return 0;
}
