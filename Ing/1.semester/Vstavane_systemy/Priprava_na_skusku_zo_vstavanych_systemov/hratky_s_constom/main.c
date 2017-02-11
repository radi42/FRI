// Funkcia 'fun#' ma parametre ...
void fun1(const int n, const struct A pole[]);  // ... konstantny int a pole konstantnych structov
void fun2(int n, const struct A * pole[]);      // ... int a pole smernikov na konstantnych struct
void fun3(int n, struct A const * pole[]);      // ... int a pole smernikov na konstantnych struct
void fun4(int n, struct A * const pole[]);      // ... int a pole konstantnych smernikov na struct
void fun5(int n, const struct A * const pole[]);// ... int a pole konstantnych smernikov na konstantny struct
void fun6(int n, struct A * pole[const]);   // C99 ... int a konstantne pole smernikov na struct
void fun7(int n, const struct A * const pole[const]);   // C99 ... int a konstantne pole konstantnych smernikov na konstantny struct
void fun8(int n, const struct A * const pole[const static 10]); // C99 ... int a konstantne pole aspon desiatich konstantnych smernikov na konstantny struct

int main(int argc, char** argv)
{
    return 0;
}
