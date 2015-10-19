#ifndef BOB_HPP_INC
#define BOB_HPP_INC

class Bob final
{
    public:
        Bob() = default;

        ~Bob() = default;
        Bob(const Bob& other) = default;
        Bob(Bob&& other) = default;
        Bob& operator=(const Bob& other) = default;
        Bob& operator=(Bob&& other) = default;

        int getJim() const noexcept;

    private:
        int m_jim = 0;
};

#endif // BOB_HPP_INC
