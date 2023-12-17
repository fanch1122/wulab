rm(list = ls())
# 安装和加载ggplot2包（如果尚未安装）
# install.packages("ggplot2")
library(ggplot2)

# 输入数据
data <- data.frame(
  Gene = c("P511", "P422", "A421", "T453", "S517", "A456", "Q410", "D415", "Q455", "R497", "D494", "R496", "D424", "R502"),
  Value = c(1.05, 0.85, 0.72, 0.39, 0.38, 0.29, 0.23, 0.22, -0.2, -0.24, -0.31, -0.37, -0.5, -1.12),
  Group = rep("SMAD4", 14)
)

data2 <- data.frame(
  Gene = c("R277", "D297", "Q330", "Q343", "D364", "K296", "D299", "D342", "A332", "K278", "S304", "S377", "A325", "V327"),
  Value = c(-1, -0.96, -0.46, -0.45, -0.42, -0.39, -0.24, -0.21, 0.22, 0.25, 0.25, 0.46, 0.64, 1.08),
  Group = rep("LAMP3", 14)
)

# 合并两组数据
combined_data <- rbind(data, data2)

# 创建ggplot对象
p <- ggplot(combined_data, aes(x = Gene, y = Value, fill = Group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Continuous Bar Plot", x = "Genes", y = "Values") +
  scale_fill_manual(values = c("SMAD4" = "blue", "LAMP3" = "red")) +
  theme_minimal()

# 显示图形
print(p)
combined_data$Gene <- reorder(combined_data$Gene, combined_data$Value)

# 创建ggplot对象
p <- ggplot(combined_data, aes(x = Gene, y = Value, fill = Group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Continuous Bar Plot", x = "Genes", y = "Values") +
  scale_fill_manual(values = c("SMAD4" = "blue", "LAMP3" = "red")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  geom_hline(yintercept = c(-0.5, 0.5), linetype = "dashed", color = "black", size = 1)
  # 显示图形
print(p)
p <- ggplot(combined_data, aes(x = Gene, y = Value, fill = Group)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_hline(yintercept = c(-0.2, 0.2), linetype = "dashed", color = "black", size = 1) +  # 添加y轴标准线
  labs(y = "ΔG Kcal/mol") +
  scale_fill_manual(values = c("SMAD4" = "blue", "LAMP3" = "red")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),panel.grid = element_blank())  # 使x轴标签倾斜
print(p)



