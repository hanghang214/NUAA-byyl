#ifndef TYPE_H
#define TYPE_H  

/* Define the type of tree node */
typedef enum nodeType{
    TOKEN_TYPE,
    TOKEN_INT,
    TOKEN_FLOAT,
    TOKEN_ID,
    TOKEN_STRING,
    TOKEN_CHAR,
    TOKEN_SYMBOL,
    NOT_A_TOKEN
} NodeType;

#endif
