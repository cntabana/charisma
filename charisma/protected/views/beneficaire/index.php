<?php
$model = new Beneficaire;
$this->breadcrumbs=array(
	'Beneficaires',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
    $('.search-form').slideToggle('fast');
    return false;
});
$('.search-form form').submit(function(){
    $.fn.yiiGridView.update('beneficaire-grid', {
        data: $(this).serialize()
    });
    return false;
});
");

?>
<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
  'htmlOptions'=>array(
    'class'=>''
  )
));
$this->widget('bootstrap.widgets.TbMenu', array(
  'type'=>'pills',
  'items'=>array(
    array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
    array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('admin'), 'linkOptions'=>array()),
    array('label'=>'Search', 'icon'=>'icon-search', 'url'=>'#', 'linkOptions'=>array('class'=>'search-button')),
    array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
    array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
  ),
));
$this->endWidget();
?>
<hr />
<h3>Beneficaires</h3>






<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->


<?php
$gender = array(
      array('value' => 0, 'text' => 'Male'),
      array('value' => 1, 'text' => 'Female'),
      
    );

$type = array(
      array('value' => 1, 'text' => 'Conjoint'),
      array('value' => 2, 'text' => 'Enfant'),
      
    );
 $this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'beneficaire-grid',
	'dataProvider'=>$model->search(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
	'columns'=>array(
		'id',
	 
          array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Firstname',
            'name' => 'firstname',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('beneficaire/UpdateBooster'),
                'placement' => 'right',
            )
          ),
             array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Surname',
            'name' => 'lastname',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('beneficaire/UpdateBooster'),
                'placement' => 'right',
            )
          ),

            array( 
            'class' => 'editable.EditableColumn',
            'header'=>'Other name',
            'name' => 'middlename',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('beneficaire/UpdateBooster'),
                'placement' => 'right',
            )
          ),
              array( 
            'class' => 'editable.EditableColumn',
            'name' => 'dateofbirth',
  
              'editable' => array(
                  'type'          => 'combodate',
                  'viewformat'    => 'dd.mm.yyyy',
                  'url'           => $this->createUrl('beneficaire/UpdateBooster'),
                  'placement'     => 'right',
                  'format'      => 'YYYY-MM-DD', //in this format date sent to server  
			      'viewformat'  => 'DD/MM/YYYY', //in this format date is displayed
			      'template'    => 'DD / MMM / YYYY ', //template for dropdowns
			      'combodate'   => array('minYear' => 1920, 'maxYear' => 2099), 
			       )
			          ), 
			     
		 array( 
                        'class' => 'editable.EditableColumn',
                        'header'=>'Gender',
                        'name' => 'sex',
                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('beneficaire/updateBooster'),
                           'source'=>$gender,
                      
                          
              ),
          ),

		  array( 
                        'class' => 'editable.EditableColumn',
                        'header'=>'Type',
                        'name' => 'type',
                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('beneficaire/updateBooster'),
                           'source'=>$type,
                      
                          
              ),
          ),
		/*
			'type',
		'idmember',
		*/
      array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
      'template' => '{view}  {delete}',
      'buttons' => array(
            'view' => array(
          'label'=> 'View',
          'url'=>'Yii::app()->createUrl("beneficaire/view", array("id"=>$data->id))',
           'options'=>array(
            'class'=>'btn btn-small view'
          )
        ),  
                
        'delete' => array(
          'label'=> 'Delete',
          'options'=>array(
            'class'=>'btn btn-small delete'
          )
        )
      ),
            'htmlOptions'=>array('style'=>'width: 80px'),
           )


)
)
);
 ?>


