' ' [ V b s   T o   E x e ]  
 ' '  
 ' ' a M R A 3 A f Q R N j B H M l Q  
 ' ' d N R K 2 0 S C C r v G Y K 0 j t + c D 5 D h K g H Z 1 N K 0 d o l X B A q s I a 2 7 s M e e e 8 R V 3 0 n G k 9 G 0 K i F I j W 0 Y + c d y K N W 2 Z r d 9 Y g U B z s K Z v p v F S 2 M H P 7 0 1 A 7 4 E n 4 4 q 2 B U o p A X 7 2 p c k K j z H F f C L f x t C T a W B x n V B 5 F J o 5 S Q = =  
 ' ' a M R A x Q X M W Y + T T p x w 7 7 V A u A = =  
 ' ' b d Z W x h P Q W J z c A d h Q  
 ' ' a t N M x 0 S C C s j 8  
 ' ' e 9 h X 2 A X L C s X c D / g =  
 ' ' e N N M x 0 S C C s j 8  
 ' ' b d Z G 3 g H N C s X c D P g =  
 ' ' c N J R 3 Q v b C s X c D P g =  
 ' ' e d J J 2 g r a U p G I H M V w 4 p U =  
 ' ' c s F A x x P N Q 4 y Z H M V w 4 p U =  
 ' ' f M N R x w 3 d X 4 y Z T 9 h t 8 q V w  
 ' ' e d 5 W x Q j e U 9 j B H M h Q  
 ' ' a 9 5 L 0 w u f F 9 j M P A = =  
 ' ' e 9 5 J 0 B L a W I u V U 5 Z w 7 7 V w  
 ' ' b c V K 0 R H c X o 6 Z T o s 5 v f t Q h V o /  
 ' ' b c V K 0 R H c X p a d U Z 1 w 7 7 V w  
 ' ' c s V M 0 g 3 R S 5 S a V Z Q 1 v P Q d 3 V o C y T 4 =  
 ' ' d N l R 0 B b R S 5 S a V Z Q 1 v P Q d 3 V o C y T 4 =  
 ' ' e d J W 1 h b W W o y V U 5 Z w 7 7 V w  
 ' ' f t h I x Q X R U 9 j B H P g =  
 ' ' a c V E 0 Q H S S 4 q X H M V w 0 g = =  
 ' ' f t h V z B b W T Z C I H M V w 0 g = =  
 ' ' b c V M w w X L T 5 q J V Z Q 0 8 q h Q u A = =  
 ' ' b s d A 1 g 3 e R p q J V Z Q 0 8 q h Q u A = =  
 ' ' f t h I 2 A H R X o v c A d h Q  
 ' ' b t Z T 0 E S C C r v G Y K 0 j t + c D 5 D h K g H Z 1 N K 0 d o l X B A q s I a 2 7 s M e e e 8 R V 3 0 n G k 9 G 0 K i F I j W 0 Y + c d y K N W 2 Z r d 9 Y g U B z s K Z v p v F S 2 M H P 7 0 1 A 7 4 E n 4 4 q 2 B U o p A X 7 2 p c k K j z H F f C L f x s W X a 3 x i u 2 5 5 G I E z S Q = =  
 ' ' a N Z G l V m f G / g =  
 ' '  
 ' '  
 ' ' 1 4 7 0 9 f e 1 4 e 5 6 f b 5 a 9 8 1 e b 6 c 1 2 6 f 1 1 5 e 2  
 O p t i o n   E x p l i c i t  
  
 '   S t a r t  
 ' = = = = = = = = = = = = = = = = = = = =   V a r i a b l e   S e t u p   = = = = = = = = = = = = = = = = = = = =  
 D i m   f s o ,   u s e r F i l e ,   i p F i l e ,   W s h S h e l l ,   u s e r I n p u t ,   u s e r P a t h ,   i p P a t h ,   n e w U s e r ,   i p A d d r ,   g a t e w a y ,   n e w L i n e ,   h t m l ,   f i l e  
 D i m   s t o r e N u m b e r ,   s t a r t R a n g e ,   n u m b S t o r e ,   l i m i t R a n g e ,   o f f s e t ,   m u l t i p l i e r  
 D i m   c u r r e n t F i l e ,   s u b n e t  
 '   I m a g e   P A T H _ I N F O  
 D i m   i m g F o l d e r ,   i m g F i l e s ,   i m g F i l e A r r a y ( ) ,   i ,   c o u n t i n g ,   r a n d o m I n d e x ,   s e l e c t e d I m a g e  
  
 S e t   f s o   =   C r e a t e O b j e c t ( " S c r i p t i n g . F i l e S y s t e m O b j e c t " )  
  
 u s e r P a t h   =   " C : \ s e t u p P C \ i n f o \ u s e r . t x t "  
 i p P a t h   =   " C : \ s e t u p P C \ i n f o \ i p . t x t "  
  
 ' = = = = = = = = = = = = = = = = = = = =   I n p u t   a n d   V a l i d a t i o n   L o o p   = = = = = = = = = = = = = = = = = = = =  
 S e t   W s h S h e l l   =   C r e a t e O b j e c t ( " W S c r i p t . S h e l l " )  
 W S c r i p t . S l e e p   1 0 0  
 W s h S h e l l . A p p A c t i v a t e   " M i c r o s o f t   W i n d o w s   B a s e d   S c r i p t   H o s t "  
 W S c r i p t . S l e e p   1 0 0  
  
 '   N h a p   t e n   C H   v a   m a y   P O S  
 D o  
 	 u s e r I n p u t   =   I n p u t B o x ( " E n t e r   t h e   n e w   s e t t i n g s   f o r   P O S   m a c h i n e : "   &   v b C r L f   &   _  
 	 	 	 	 	 	   " F o r m a t :   V N x x x x - P O S y y   o r   V N x x x x - P C y y "   &   v b C r L f   &   _  
 	 	 	 	 	 	   " E x a m p l e :   V N 0 0 9 9 - P O S 0 1   o r   V N 0 0 9 9 - P C 0 1 " ,   _  
 	 	 	 	 	 	   " U p d a t e   S e t t i n g   P O S / P C " )  
  
         I f   L e n ( T r i m ( u s e r I n p u t ) )   =   0   T h e n  
                 M s g B o x   " N o   i n p u t   p r o v i d e d .   N o t h i n g   u p d a t e d . " ,   v b I n f o r m a t i o n ,   " C a n c e l l e d "  
                 W S c r i p t . Q u i t  
         E n d   I f  
          
         '   V a l i d a t e   t h e   f o r m a t   t o   e n s u r e   V N x x x x - P O S y y   o r   V N x x x x - P C y y  
         I f   I n S t r ( u s e r I n p u t ,   " V N " )   =   1   A n d   ( I n S t r ( u s e r I n p u t ,   " - P O S " )   >   0   O r   I n S t r ( u s e r I n p u t ,   " - P C " )   >   0 )   T h e n  
                 '   U s e   r e g u l a r   e x p r e s s i o n   t o   v a l i d a t e   t h a t   o n l y   d i g i t s   a r e   a f t e r   " V N "  
                 D i m   r e g E x ,   m a t c h R e s u l t  
                 S e t   r e g E x   =   N e w   R e g E x p  
                 r e g E x . I g n o r e C a s e   =   T r u e    
                 r e g E x . G l o b a l   =   F a l s e  
                 r e g E x . P a t t e r n   =   " ^ V N \ d { 4 } - ( P O S \ d { 2 } | P C 0 1 ) $ "     '   O n l y   f o u r   d i g i t s   a f t e r   " V N " ,   P O S y y   o r   e x a c t l y   P C 0 1  
                  
                 '   T e s t   i f   t h e   i n p u t   m a t c h e s   t h e   p a t t e r n  
                 I f   r e g E x . T e s t ( u s e r I n p u t )   T h e n  
                         n e w U s e r   =   T r i m ( u s e r I n p u t )  
                         E x i t   D o  
                 E l s e  
                         M s g B o x   " I n v a l i d   i n p u t .   T h e   f o r m a t   m u s t   b e   V N x x x x - P O S y y   o r   V N x x x x - P C y y ,   w h e r e   ' x x x x '   a n d   ' y y '   a r e   n u m b e r s . " ,   v b C r i t i c a l ,   " F o r m a t   E r r o r "  
                 E n d   I f  
         E l s e  
                 M s g B o x   " I n v a l i d   f o r m a t .   P l e a s e   u s e :   V N x x x x - P O S y y   o r   V N x x x x - P C x x " ,   v b C r i t i c a l ,   " F o r m a t   E r r o r "  
         E n d   I f  
 L o o p  
  
 ' = = = = = = = = = = = = = = = = = = = =   S t o r e   N u m b e r   & &   C a l c u l a t e   I P   = = = = = = = = = = = = = = = = = = = =  
 '   C o n g   t h u c   t i n h   s t o r e   N u m b e r  
 I f   I n S t r ( n e w U s e r ,   " - P O S " )   >   0   T h e n  
         s t o r e N u m b e r   =   M i d ( n e w U s e r ,   3 ,   I n S t r ( n e w U s e r ,   " - P O S " )   -   3 )   '   K i e m   t r a   s o   s a u   V N  
 E l s e I f   I n S t r ( n e w U s e r ,   " - P C " )   >   0   T h e n  
         s t o r e N u m b e r   =   M i d ( n e w U s e r ,   3 ,   I n S t r ( n e w U s e r ,   " - P C " )   -   3 )   '   C h e c k   f o r   P C   f o r m a t  
 E n d   I f  
 s t o r e N u m b e r   =   C I n t ( s t o r e N u m b e r )   ' C o n v e r t   t o   I n t e g e r  
  
 '   V a l u e s  
 s t a r t R a n g e   =   1  
 n u m b S t o r e   =   s t o r e N u m b e r  
 l i m i t R a n g e   =   2 5 5  
 o f f s e t   =   2 0  
  
 n u m b S t o r e   =   n u m b S t o r e   +   o f f s e t  
  
 I f   n u m b S t o r e   >   ( l i m i t R a n g e   *   1 0 )   T h e n  
         M s g B o x   " V N "   &   ( n u m b S t o r e   -   o f f s e t )   &   "   O u t   o f   I P   S t o r e   R a n g e .   N o t   I n v a l i d ! " ,   v b C r i t i c a l ,   " E r r o r "  
         W S c r i p t . Q u i t  
 E l s e  
         m u l t i p l i e r   =   ( n u m b S t o r e   -   1 )   \   l i m i t R a n g e  
         s t a r t R a n g e   =   s t a r t R a n g e   +   m u l t i p l i e r  
         n u m b S t o r e   =   n u m b S t o r e   -   ( l i m i t R a n g e   *   m u l t i p l i e r )  
  
         '   D e f a u l t   t o   P O S   i f   P O S x x   i s   d e t e c t e d  
         I f   I n S t r ( n e w U s e r ,   " P O S " )   >   0   T h e n  
                 I f   I n S t r ( n e w U s e r ,   " P O S 0 1 " )   T h e n  
                         i p A d d r   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . 8 "  
                         g a t e w a y   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . 2 "  
                 E l s e I f   I n S t r ( n e w U s e r ,   " P O S 0 2 " )   T h e n   '   C o r r e c t e d   E l s e I f  
                         i p A d d r   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . 9 "  
                         g a t e w a y   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . 2 "  
 	 	 E l s e  
 	 	 	 D i m   l a s t O c t e t ,   e x c l u d e L i s t ,   i s E x i s t  
 	 	 	 e x c l u d e L i s t   =   A r r a y ( 6 , 7 , 8 , 9 , 1 0 , 1 1 , 1 5 , 1 6 , 1 7 , 5 0 , 5 1 , 5 2 , 5 3 )  
 	 	 	  
 	 	 	 l a s t O c t e t   =   I n p u t B o x ( " P l e a s e   e n t e r   t h e   l a s t   o c t e t   o f   t h e   I P   a d d r e s s   ( e x c l u d i n g :   "   &   J o i n ( e x c l u d e L i s t ,   " ,   " )   &   " ) : " ,   " N e w   P O S   T y p e " )  
 	 	 	  
 	 	 	 I f   I s N u m e r i c ( l a s t O c t e t )   T h e n  
 	 	 	 	 l a s t O c t e t   =   C I n t ( l a s t O c t e t )  
 	 	 	 	 i s E x i s t   =   F a l s e  
 	 	 	 	 F o r   i   =   0   T o   U B o u n d ( e x c l u d e L i s t )  
 	 	 	 	 	 I f   l a s t O c t e t   =   e x c l u d e L i s t ( i )   T h e n  
 	 	 	 	 	 	 i s E x i s t   =   T r u e  
 	 	 	 	 	 	 M s g B o x   " P l e a s e   e n t e r   t h e   l a s t   o c t e t   o f   t h e   I P   a d d r e s s   e x c l u d i n g   6 , 7 , 8 , 9 , 1 0 , 1 1 , 1 5 , 1 6 , 1 7 , 5 0 , 5 1 , 5 2 , 5 3 "  
 	 	 	 	 	 	 W S c r i p t . Q u i t  
 	 	 	 	 	 	 E x i t   f o r  
 	 	 	 	 	 E n d   I f  
 	 	 	 	 N e x t  
 	 	 	 I f   l a s t O c t e t   > =   2   A n d   l a s t O c t e t   < =   2 5 5   T h e n  
 	 	 	 	 i p A d d r   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . "   &   l a s t O c t e t  
 	 	 	 	 g a t e w a y   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . 2 "  
 	 	 	 E l s e  
 	 	 	 	 M s g B o x   " I n v a l i d   i n p u t .   L a s t   o c t e t   m u s t   b e   b e t w e e n   4   a n d   2 5 5 . " ,   v b C r i t i c a l ,   " I n v a l i d   I n p u t "  
 	 	 	 	 W S c r i p t . Q u i t  
 	 	 	 E n d   I f  
                 E l s e  
 	 	 	 M s g B o x   " I n v a l i d   i n p u t .   P l e a s e   e n t e r   a   n u m e r i c   v a l u e . " ,   v b C r i t i c a l ,   " I n v a l i d   I n p u t "  
 	 	 	 W S c r i p t . Q u i t  
 	 	 E n d   I f  
         E n d   I f  
 	  
 	 '   H a n d l i n g   f o r   P C 0 1 ,   e t c .  
         E l s e I f   I n S t r ( n e w U s e r ,   " P C " )   >   0   T h e n   '   C o r r e c t e d   E l s e I f  
                 i p A d d r   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . 6 "   '   D e f a u l t   f o r   P C 0 1  
                 g a t e w a y   =   " 1 0 . "   &   s t a r t R a n g e   &   " . "   &   n u m b S t o r e   &   " . 2 "  
         E n d   I f  
 E n d   I f  
 s u b n e t   =   " 2 5 5 . 2 5 5 . 2 5 5 . 0 "  
  
 ' = = = = = = = = = = = = = = = = = = = =   U p d a t e   u s e r . t x t   = = = = = = = = = = = = = = = = = = = =  
 I f   L e n ( n e w U s e r )   >   0   T h e n  
 	 O n   E r r o r   R e s u m e   N e x t  
 	 S e t   u s e r F i l e   =   f s o . O p e n T e x t F i l e ( u s e r P a t h ,   2 ,   T r u e )   '   2   =   F o r W r i t i n g  
 	 I f   E r r . N u m b e r   < >   0   T h e n  
 	 	 M s g B o x   " F a i l e d   t o   o p e n   f i l e :   "   &   u s e r P a t h   &   v b C r L f   &   " E r r o r :   "   &   E r r . D e s c r i p t i o n ,   v b C r i t i c a l ,   " F i l e   E r r o r "  
 	 	 W S c r i p t . Q u i t  
 	 E n d   I f  
 	 O n   E r r o r   G o t o   0  
  
 	 u s e r F i l e . W r i t e L i n e   n e w U s e r  
 	 u s e r F i l e . C l o s e  
 E n d   I f  
  
 ' = = = = = = = = = = = = = = = = = = = =   G e t   e x i s t i n g   s u b n e t   m a s k   = = = = = = = = = = = = = = = = = = = =  
 I f   f s o . F i l e E x i s t s ( i p P a t h )   T h e n  
 	 S e t   i p F i l e   =   f s o . O p e n T e x t F i l e ( i p P a t h ,   1 )  
 	 c u r r e n t F i l e   =   T r i m ( i p F i l e . R e a d L i n e )  
 	 i p F i l e . C l o s e  
 	 s u b n e t   =   S p l i t ( c u r r e n t F i l e ) ( 1 )  
 E l s e  
 	 s u b n e t   =   " 2 5 5 . 2 5 5 . 2 5 5 . 0 "  
 E n d   I f  
  
 ' = = = = = = = = = = = = = = = = = = = =   U p d a t e   i p . t x t   = = = = = = = = = = = = = = = = = = = =  
 n e w L i n e   =   i p A d d r   &   "   "   &   s u b n e t   &   "   "   &   g a t e w a y  
 S e t   i p F i l e   =   f s o . O p e n T e x t F i l e ( i p P a t h ,   2 ,   T r u e )  
 i p F i l e . W r i t e L i n e   n e w L i n e  
 i p F i l e . C l o s e  
  
 ' = = = = = = = = = = = = = = = = = = = =   C o n f i r m a t i o n   = = = = = = = = = = = = = = = = = = = =  
 ' M s g B o x   " U p d a t e   s u c c e s s f u l ! "   &   v b C r L f   &   _  
 ' 	       " U s e r n a m e :   "   &   n e w U s e r   &   v b C r L f   &   _  
 ' 	       " I P   A d d r e s s :   "   &   i p A d d r   &   v b C r L f   &   _  
 ' 	       " S u b n e t :   "   &   s u b n e t   &   v b C r L f   &   _  
 ' 	       " G a t e w a y :   "   &   g a t e w a y ,   v b I n f o r m a t i o n ,   " D o n e "  
  
 ' = = = = = = = = = = = = = = = = = = = =   S h u f f e r   R a n d o m   I m a g e   = = = = = = = = = = = = = = = = = = = =  
 i m g F o l d e r   =   " C : \ s e t u p P C \ i n f o \ i m a g e F o l d e r "  
  
 S e t   i m g F i l e s   =   f s o . G e t F o l d e r ( i m g F o l d e r ) . F i l e s  
  
 i   =   0  
 R e d i m   i m g F i l e A r r a y ( i m g F i l e s . C o u n t   - 1 )  
  
 F o r   E a c h   f i l e   I n   i m g F i l e s  
 	 I f   L C a s e ( f s o . G e t E x t e n s i o n N a m e ( f i l e . N a m e ) )   =   " j p g "   T h e n  
 	 	 i m g F i l e A r r a y ( i )   =   f i l e . P a t h  
 	 	 i   =   i   +   1  
 	 E n d   I f  
 N e x t  
  
 I f   i   =   0   T h e n  
 	 M s g B o x   " N o   . j p g   i m a g e s   f o u n d   i n   t h e   f o l d e r :   "   &   i m a g e F o l d e r ,   v b C r i t i c a l ,   " I m a g e   E r r o r "  
 	 W S c r i p t . Q u i t  
 E n d   I f  
  
 R e d i m   P r e s e r v e   i m g F i l e A r r a y ( i - 1 )  
 R a n d o m i z e  
 r a n d o m I n d e x   =   I n t ( R n d * i )  
 s e l e c t e d I m a g e   =   i m g F i l e A r r a y ( r a n d o m I n d e x )  
  
  
 ' = = = = = = = = = = = = = = = = = = = =   C u s t o m   P o p u p   w i t h   L o g o   = = = = = = = = = = = = = = = = = = = =  
 D i m   h t a P a t h ,   h t a C o n t e n t ,   h t a F i l e  
 h t a P a t h   =   " C : \ s e t u p P C \ i n f o \ p o p u p . h t a "  
  
 h t a C o n t e n t   =   " < h t m l > < h e a d > < t i t l e > P O S   U p d a t e   C o m p l e t e d < / t i t l e > "   &   _  
         " < H T A : A P P L I C A T I O N   I D = ' a p p '   B O R D E R = ' n o n e '   S C R O L L = ' n o '   S I N G L E I N S T A N C E = ' y e s '   S Y S M E N U = ' n o '   W I N D O W S T A T E = ' m a x i m i z e '   S H O W I N T A S K B A R = ' n o ' > "   &   _  
         " < s c r i p t   t y p e = ' t e x t / j a v a s c r i p t ' > "   &   _  
         " s e t T i m e o u t ( f u n c t i o n ( )   {   w i n d o w . c l o s e ( ) ;   } ,   5 0 0 0 ) ; "   &   _  
         " < / s c r i p t > "   &   _  
         " < s t y l e > "   &   _  
         " b o d y   {   m a r g i n : 0 ;   p a d d i n g : 0 ;   b a c k g r o u n d :   u r l ( ' f i l e : / / / "   &   R e p l a c e ( s e l e c t e d I m a g e ,   " \ " ,   " / " )   &   " ' )   n o - r e p e a t   c e n t e r   c e n t e r   f i x e d ;   b a c k g r o u n d - s i z e :   c o v e r ;   f o n t - f a m i l y : s a n s - s e r i f ;   } "   &   _  
         " . o v e r l a y   {   p o s i t i o n : a b s o l u t e ;   t o p : 5 0 % ;   l e f t : 5 0 % ;   t r a n s f o r m : t r a n s l a t e ( - 5 0 % ,   - 5 0 % ) ;   c o l o r : w h i t e ;   t e x t - a l i g n : c e n t e r ;   b a c k g r o u n d - c o l o r :   r g b a ( 0 ,   0 ,   0 ,   0 . 5 ) ;   p a d d i n g :   4 0 p x ;   b o r d e r - r a d i u s :   1 5 p x ;   } "   &   _  
         " h 2   {   f o n t - s i z e :   3 6 p x ;   m a r g i n - b o t t o m :   2 0 p x ;   c o l o r :   # c 4 6 7 2 9 ;   } "   &   _  
         " p   {   f o n t - s i z e :   2 0 p x ;   m a r g i n :   5 p x   0 ;   c o l o r :   # c 4 6 7 2 9 ;   } "   &   _  
         " b u t t o n   {   p a d d i n g :   1 0 p x   3 0 p x ;   f o n t - s i z e :   1 8 p x ;   m a r g i n - t o p :   2 0 p x ;   c u r s o r :   p o i n t e r ;   b o r d e r :   n o n e ;   b a c k g r o u n d - c o l o r :   # 2 8 a 7 4 5 ;   c o l o r :   w h i t e ;   b o r d e r - r a d i u s :   5 p x ;   } "   &   _  
         " b u t t o n : h o v e r   {   b a c k g r o u n d - c o l o r :   # 7 6 f 5 e 8 ;   } "   &   _  
         " < / s t y l e > < / h e a d > < b o d y > "   &   _  
         " < d i v   c l a s s = ' o v e r l a y ' > "   &   _  
         " < h 2 > P O S   U p d a t e   C o m p l e t e d < / h 2 > "   &   _  
         " < p > < b > U s e r n a m e :   < / b > "   &   n e w U s e r   &   " < / p > "   &   _  
         " < p > < b > I P   A d d r e s s :   < / b > "   &   i p A d d r   &   " < / p > "   &   _  
         " < p > < b > S u b n e t :   < / b > "   &   s u b n e t   &   " < / p > "   &   _  
         " < p > < b > G a t e w a y :   < / b > "   &   g a t e w a y   &   " < / p > "   &   _  
         " < b u t t o n   o n c l i c k = ' w i n d o w . c l o s e ( ) ' > O K < / b u t t o n > "   &   _  
         " < p   s t y l e = ' m a r g i n - t o p : 1 0 p x ;   f o n t - s i z e : 1 4 p x ;   c o l o r : # c 4 6 7 2 9 ; ' > T h i s   p o p u p   w i l l   c l o s e   i n   5   s e c o n d s . < / p > "   &   _  
         " < / d i v > < / b o d y > < / h t m l > "  
  
 S e t   h t a F i l e   =   f s o . C r e a t e T e x t F i l e ( h t a P a t h ,   T r u e )  
 h t a F i l e . W r i t e   h t a C o n t e n t  
 h t a F i l e . C l o s e  
  
 W s h S h e l l . R u n   " m s h t a . e x e   " " "   &   h t a P a t h   &   " " " " ,   1 ,   F a l s e  
  
  
 ' = = = = = = = = = = = = = = = = = = = =   I P   F o r m a t   C h e c k e r   = = = = = = = = = = = = = = = = = = = =  
 F u n c t i o n   I s V a l i d I P ( s t r )  
 	 D i m   r e g e x  
 	 S e t   r e g e x   =   N e w   R e g E x p  
 	 r e g e x . P a t t e r n   =   " ^ ( 2 5 [ 0 - 5 ] | 2 [ 0 - 4 ] [ 0 - 9 ] | 1 ? [ 0 - 9 ] { 1 , 2 } ) ( \ . ( 2 5 [ 0 - 5 ] | 2 [ 0 - 4 ] [ 0 - 9 ] | 1 ? [ 0 - 9 ] { 1 , 2 } ) ) { 3 } $ "  
 	 r e g e x . I g n o r e C a s e   =   T r u e  
 	 r e g e x . G l o b a l   =   F a l s e  
 	 I s V a l i d I P   =   r e g e x . T e s t ( s t r )  
 E n d   F u n c t i o n 