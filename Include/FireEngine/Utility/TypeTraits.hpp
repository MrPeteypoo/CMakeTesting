#ifndef FIRE_TYPE_TRAITS_HPP
#define FIRE_TYPE_TRAITS_HPP

// This file exists to extend the type_traits library with syntactic sugar.
#include <type_traits>

namespace fire
{
    
    template <typename T, typename Check>
    constexpr bool is_any_f()
    {
        return std::is_same<T, Check>::value;
    }

    template <typename T, typename Check, typename... Args>
    constexpr bool is_any_f()
    {
        return is_any_f<T, Check> || is_any_f<T, Args...>;
    }

    template <typename T, typename... Args>
    constexpr bool is_any_v = is_any_f<T, Args...>();

    template <typename T>
    constexpr bool is_arithmetic_v = std::is_arithmetic<T>::value;

    template <typename T, typename... Args>
    constexpr bool is_arithmetic_excluding_v = is_arithmetic_v<T> && !is_any_v<T, Args...>;

    template <typename T>
    constexpr bool is_signed_v = std::is_signed<T>::value;

    template <typename T>
    constexpr bool is_unsigned_v = std::is_signed<T>::value;

    template <typename T>
    using enable_if_signed_t = typename std::enable_if_t<is_signed_v<T>, T>;

    template <typename T>
    using enable_if_unsigned_t = typename std::enable_if_t<is_unsigned_v<T>, T>;
}

#endif // FIRE_TYPE_TRAITS_HPP
