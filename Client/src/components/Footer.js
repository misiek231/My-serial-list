import React from 'react';
import '../styles/Footer.scss';

const Footer = () => {
    return ( 
        <footer>
            <p>Stronę wykonali:</p><br></br>
            <code>Konrad Kolasa - FrontEnd</code><br></br>
            <code>Michał Woźniak - BackEnd</code>

            <p className="Versatile">&copy; Copyright:<a href="https://github.com/VersatileSoft" target="_blank" rel="noopener noreferrer">Versatile Software</a></p>
        </footer>
     );
}
 
export default Footer;