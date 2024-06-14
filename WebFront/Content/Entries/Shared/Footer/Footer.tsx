import * as React from 'react';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import Link from '@mui/material/Link';
import { Box } from '@mui/material';
import file from '../../../../Files/Public-Oferta.docx';
export default function Footer() {
    return (
        <Box
            sx={{
                p: 6,
                width: 'auto',
                backgroundColor: 'white',
            }}
            component="footer"
        >
            <Container maxWidth="sm">
                <Typography variant="body2" color="text.secondary" align="center">
                    <Link color="inherit" href={file}>
                        {'Публичная оферта'}
                    </Link>
                </Typography>
            </Container>
        </Box>
    );
}
