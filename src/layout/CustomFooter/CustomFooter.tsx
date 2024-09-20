import { FC } from "react";

import { Layout, Typography } from "antd";

const { Footer } = Layout;
const { Text } = Typography;

const styles = {
  footer: {
    position: "fixed",
    textAlign: "center",
    width: "100%",
    bottom: "0",
    backgroundColor: "transparent"
  }
} as const;

const CustomFooter: FC = () => {
  return (
    <Footer style={styles.footer}>
      <Typography>
        <Text>
          Built for ETHGlobal Singapore 🇸🇬 2024 with ❤️
        </Text>
      </Typography>
    </Footer>
  );
};

export default CustomFooter;
