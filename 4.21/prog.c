/* Stack of Doubles */

#include <stdio.h>
#include <stdlib.h>

struct stackdbl {
    double *stackptr, *bottomptr;
    int stack_size;
    int free_slots;
};

void stackdbl_init(struct stackdbl **stack)
{
    *stack = malloc(sizeof(struct stackdbl));
    (*stack)->stack_size = 1;
    (*stack)->free_slots = (*stack)->stack_size;
    (*stack)->stackptr = malloc(((*stack)->stack_size) * sizeof(double));
    (*stack)->bottomptr = (*stack)->stackptr;
}

        
void stackdbl_realloc(struct stackdbl **stack)
{
    double *tmp = malloc(2 * (*stack)->stack_size * sizeof(double));
    for(int i = 0; i < (*stack)->stack_size; i++) {
        *tmp = *((*stack)->bottomptr);
        tmp += 1;
        (*stack)->bottomptr += 1;
    }
    (*stack)->bottomptr = tmp - (*stack)->stack_size;
    (*stack)->free_slots = (*stack)->stack_size;
    (*stack)->stack_size *= 2;
    (*stack)->stackptr = tmp - (*stack)->stack_size / 2;
    free((*stack)->stackptr);
    (*stack)->stackptr = tmp;
}

void stackdbl_push(struct stackdbl **stack, double data)
{
    if(!(*stack)->free_slots)
        stackdbl_realloc(&(*stack));
    *((*stack)->stackptr) = data;
    (*stack)->stackptr += 1;
    ((*stack)->free_slots) -= 1;
}

void stackdbl_pop(struct stackdbl **stack, double *data)
{
    (*stack)->stackptr -= 1;
    *data = *((*stack)->stackptr);
    ((*stack)->free_slots) += 1;
}

int stackdbl_empty(struct stackdbl **stack)
{
    return ((*stack)->stack_size == (*stack)->free_slots) ? 1 : 0;
}

void stackdbl_destroy(struct stackdbl **stack)
{
    free(*stack);
}

int main()
{
    double x;
    struct stackdbl *sp = NULL;
    stackdbl_init(&sp);
    stackdbl_push(&sp, 3.4);
    stackdbl_push(&sp, 1.4);
    if(!stackdbl_empty(&sp)) {
        stackdbl_pop(&sp, &x);
        printf("%f\n", x);
    }
    stackdbl_push(&sp, -5.0);
    if(!stackdbl_empty(&sp)) {
        stackdbl_pop(&sp, &x);
        printf("%f\n", x);
    }
    if(!stackdbl_empty(&sp)) {
        stackdbl_pop(&sp, &x);
        printf("%f\n", x);
    }
    stackdbl_destroy(&sp);
    return 0;
}